//
//  HomeRefactored.swift
//  Turismo_Manaus
//
//  Home View refatorada para MVVM - Usa HomeViewModel e FilterViewModel
//

import Foundation
import SwiftUI
import GameKit
import CoreLocation

struct HomeRefactored: View {
    // MARK: - ViewModels
    @StateObject private var homeViewModel: HomeViewModel
    @StateObject private var filterViewModel = FilterViewModel()
    @StateObject private var locationService = LocationService()
    @StateObject private var dataService = DataService()
    
    // MARK: - Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default
    ) private var desafios: FetchedResults<Desafios>
    
    // MARK: - State
    @State private var selectedTab: Tabs = .home
    @State private var currentIndex = 10
    @State private var isDetailViewShown = false
    
    // MARK: - Initialization
    init(locationViewModel: LocationViewModel) {
        self._homeViewModel = StateObject(wrappedValue: HomeViewModel(locationViewModel: locationViewModel))
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header com filtros
                headerView
                
                // Conteúdo principal
                mainContentView
                
                Spacer()
            }
        }
        .sheet(isPresented: $filterViewModel.isShowingFilterView) {
            FilterView(viewModel: filterViewModel)
        }
        .sheet(isPresented: $homeViewModel.isShowingModal) {
            ChallengeModalView(
                viewModel: homeViewModel,
                context: viewContext
            )
        }
        .onAppear {
            setupInitialData()
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Spacer()
            
            // Botão de filtros
            Button(action: {
                filterViewModel.isShowingFilterView.toggle()
                locationService.requestSingleLocation()
            }) {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .frame(width: 21.662, height: 18.056)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .background(Color.clear)
    }
    
    // MARK: - Main Content View
    private var mainContentView: some View {
        VStack(spacing: 24) {
            // Informações de filtros ativos
            if filterViewModel.hasActiveFilters {
                ActiveFiltersView(viewModel: filterViewModel)
            }
            
            // Seção do carrossel
            VStack(spacing: 16) {
                Text("Descubra Manaus")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Carrossel de pontos turísticos
                CarrosselView(
                    pontos: filteredPoints,
                    currentIndex: $currentIndex
                )
            }
            
            // Botão sortear
            VStack(spacing: 12) {
                Text("Não sabe onde ir?")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                
                Button(action: {
                    sortearPonto()
                }) {
                    HStack {
                        Image(systemName: "dice")
                        Text("Sortear Destino")
                    }
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColorYellow)
                    .padding(.horizontal, 26)
                    .padding(.vertical, 18)
                    .background(Color.bgGlass1)
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.bgGlass1, lineWidth: 2)
                    )
                }
                .disabled(filteredPoints.isEmpty)
                .opacity(filteredPoints.isEmpty ? 0.5 : 1.0)
            }
        }
        .padding()
    }
    
    // MARK: - Computed Properties
    private var filteredPoints: [PontoTuristico] {
        let allPoints = dataService.pontosDisponiveis
        let filtered = filterViewModel.aplicarFiltros(a: allPoints)
        
        // Atualiza distâncias se necessário
        if locationService.hasLocationPermission {
            dataService.atualizarDistancias(
                latitudeUsuario: locationService.latitude,
                longitudeUsuario: locationService.longitude
            )
        }
        
        return filtered
    }
    
    // MARK: - Private Methods
    private func setupInitialData() {
        // Inicia serviços de localização
        locationService.requestLocationPermission()
        
        // Sincroniza filtros entre ViewModels
        syncFilters()
    }
    
    private func syncFilters() {
        // Mantém os filtros sincronizados entre HomeViewModel e FilterViewModel
        homeViewModel.selectedCategoria = filterViewModel.selectedCategoria
        homeViewModel.selectedHorario = filterViewModel.selectedHorario
        homeViewModel.selectedDistancia = filterViewModel.selectedDistancia
        homeViewModel.selectedPreco = filterViewModel.selectedPreco
    }
    
    private func sortearPonto() {
        guard !filteredPoints.isEmpty else {
            print("Nenhum ponto disponível para sorteio")
            return
        }
        
        homeViewModel.pontoSelecionado = filteredPoints.randomElement()
        homeViewModel.isShowingModal = true
    }
}

// MARK: - Supporting Views

struct ActiveFiltersView: View {
    @ObservedObject var viewModel: FilterViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Filtros Ativos (\(viewModel.activeFiltersCount))")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                
                Text(viewModel.activeFiltersDescription)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Button("Limpar") {
                viewModel.limparFiltros()
            }
            .font(.caption)
            .foregroundColor(.accentColorYellow)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.bgGlass2.opacity(0.3))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct CarrosselView: View {
    let pontos: [PontoTuristico]
    @Binding var currentIndex: Int
    
    var body: some View {
        if pontos.isEmpty {
            EmptyStateView()
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(Array(pontos.enumerated()), id: \.element.id) { index, ponto in
                        CardPoint(ponto: ponto, isSelected: index == currentIndex)
                            .onTapGesture {
                                currentIndex = index
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "map")
                .font(.system(size: 48))
                .foregroundColor(.white.opacity(0.5))
            
            Text("Nenhum ponto encontrado")
                .font(.headline)
                .foregroundColor(.white)
            
            Text("Ajuste os filtros para ver mais opções")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(height: 200)
    }
}

struct ChallengeModalView: View {
    @ObservedObject var viewModel: HomeViewModel
    let context: NSManagedObjectContext
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            if let ponto = viewModel.pontoSelecionado {
                VStack(spacing: 20) {
                    Text("Desafio Lançado!")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Visite \(Text(ponto.name).bold()) pela primeira vez no prazo de 1 semana.")
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    // Imagem do ponto
                    if let imageResource = ponto.imageResource {
                        Image(imageResource)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300, maxHeight: 200)
                            .cornerRadius(15)
                    }
                    
                    // Botões de ação
                    HStack(spacing: 16) {
                        Button("Recusar") {
                            viewModel.recusarDesafio()
                        }
                        .buttonStyle(SecondaryButtonStyle())
                        
                        Button("Aceitar") {
                            viewModel.aceitarDesafio(context: context)
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                }
                .padding()
                .background(Color.bgGlass1)
                .cornerRadius(20)
                .padding()
            }
        }
    }
}

// MARK: - Button Styles
struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.headline)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.bgGlass1)
            .cornerRadius(100)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.bgGlass1, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// MARK: - Supporting Types
enum Tabs {
    case home
    case challenges
    case profile
}

#Preview {
    HomeRefactored(locationViewModel: LocationViewModel())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
} 