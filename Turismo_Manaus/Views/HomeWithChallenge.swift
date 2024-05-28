//
//  HomeWithChallenge.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 23/05/24.
//

import SwiftUI
import SceneKit
import GameKit
import CoreLocation
import Foundation

struct HomeWithChallenge : View {
    @State var selectedCategoria = Categorias.todos
    @State var selectedHorario = Horarios.todos
    @State var selectedDistancia = Distancias.todos
    @State var selectedPreco = Precos.todos
    @ObservedObject var locationViewModel: LocationViewModel
    @State var player = GKLocalPlayer.local
    @Environment(\.managedObjectContext) private var viewContext
    @State var isShowingFilterView = false
    @State var isShowingModal = false
    @State private var selectedTab: Tabs = .home
    @State var currentIndex = 10
    @State private var isDetailViewShown = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default) private var desafios: FetchedResults<Desafios>
    
    var body: some View {
        if isDetailViewShown {
            ChallengeDescription(isDetailViewShown: $isDetailViewShown, locationViewModel: locationViewModel)
                .onAppear {
                    GKAccessPoint.shared.isActive = false
                }
        } else {
            ZStack {
                
                Color.backgroundColor
                    .ignoresSafeArea()
                
                VStack{
                    VStack (spacing: 16){
                        VStack{
                            Text("Olá, \(player.displayName)!")
                                .font(.title)
                                .bold()
                            Text("Para onde vamos hoje?")
                                .font(.title3)
                                .fontWeight(.thin)

                        }
                        
                        VStack(spacing: 16) {
                            Carrossel(currentIndex: $currentIndex)
                            
                            HStack {
                                // Iniciar Random
                                Button(action: {
                                    Task{
                                        locationViewModel.pontoSelecionado = selecionarPontoTuristicoAleatorio()
                                        for (index, element) in PontosTuristicos.enumerated(){
                                            if locationViewModel.pontoSelecionado?.name == element.name{
                                                withAnimation(Animation.smooth) {
                                                    currentIndex = index
                                                    Task {
                                                        try await Task.sleep(nanoseconds: 1_000_000_000) // Wait for 2 seconds
                                                        isShowingModal.toggle()
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                    
                                    
                                }, label: {
                                    ZStack {
                                        Color.bgGlass1
                                            .cornerRadius(100.0)
                                        Text("Sortear")
                                            .font(.headline)
                                            .foregroundColor(.accentColorYellow)
                                            .padding(.horizontal, 16.0)
                                            .padding(.vertical, 12.0)
                                    }
                                    .frame(width: 96, height: 46)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100.0)
                                            .stroke(Color.bgGlass1, lineWidth: 2)
                                    )
                                    
                                })
                                
                                
                                // Filtros
                                Button(action: {
                                    isShowingFilterView.toggle()
                                    calculaDistancias()
                                }, label: {
                                    
                                    Image(systemName: "slider.horizontal.3")
                                        .resizable()
                                        .frame(width: 21.662, height: 18.056)
                                })
                                .padding()
                                .sheet(isPresented: $isShowingFilterView) {
                                    FilterView(selectedCategoria: $selectedCategoria, selectedHorario: $selectedHorario, selectedDistancia: $selectedDistancia, selectedPreco: $selectedPreco, isShowingFilterView: $isShowingFilterView, locationViewModel: locationViewModel)
                                    
                                        .presentationDetents([.large])
                                        .presentationBackground(content: {
                                            Color(.bgGlass2)
                                                .blur(radius: 25)
                                        })
                                        .onAppear {
                                            GKAccessPoint.shared.isActive = false
                                        }
                                        .onDisappear {
                                            GKAccessPoint.shared.isActive = true
                                        }
                                }
                                
                            }
                            .padding()
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .sheet(isPresented: $isShowingModal) {
                        if let ponto = locationViewModel.pontoSelecionado {
                            ZStack {
                                Color.black
                                    .opacity(0.8)
                                
                                VStack(spacing: 12) {
                                    Text("Desafio lançado!")
                                        .font(.title)
                                    Text("Visite o(a) \( Text(ponto.name).bold())  pela primeira vez no prazo de 1 semana.")
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                    Image(transformString(ponto.name))
                                        .resizable()
                                        .scaledToFit()
                                        .scaledToFill()
                                        .frame(width: 358, height: 176)
                                        .cornerRadius(15.0)
                                        .padding(.vertical, 24.0)
                                    
                                    HStack{
                                        
                                        // Aceitar
                                        Button(action: {
                                            isShowingModal = false
                                        }
                                               , label: {
                                            ZStack {
                                                
                                                HStack {
                                                    Text("Ok")
                                                        .foregroundStyle(.accentColorYellow)
                                                        .font(.headline)
                                                }
                                                .padding(.vertical,12.0)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .background(Color.bgGlass1)
                                            .cornerRadius(100.0)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100.0)
                                                    .stroke(Color.bgGlass1, lineWidth: 2)
                                            )
                                            
                                        })
                                    }
                                    
                                    Text("")
                                    Text("")
                                    
                                }
                                .padding(.horizontal, 16.0)
                                .padding(.vertical,24.0)
                                .foregroundStyle(.white)
                                
                                
                            }.presentationDetents([.fraction(0.6)])
                                .ignoresSafeArea()
                                .presentationBackground(content: {
                                    Color(.bgGlass2)
                                        .blur(radius: 25)
                                })
                            
                            
                        } else {
                            Text("Nenhum filtro selecionado")
                        }
                        
                    }
                    
                    if desafios.contains(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID }) {
                        Button(action: {
                            isDetailViewShown.toggle()
                        }, label: {
                            ChallengeCard()
                        })
                    }
                    
                }
                .padding()
                .padding()
            }
            .onAppear {
                GKAccessPoint.shared.isActive = true
            }
            
        }
        
    }
    
    func calculaDistancias() {
        print(".....")
        for i in 0..<PontosTuristicos.count {
            let transformedString = transformString(PontosTuristicos[i].name)
            print(transformedString)
            let location1 = CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
            let location2 = CLLocation(latitude: Double(PontosTuristicos[i].latitude) ?? 0.0, longitude: Double(PontosTuristicos[i].longitude) ?? 0.0)
            let distanceinMeters = (location1.distance(from: location2))
            let distanceInKilometers = distanceinMeters/1000
            print(PontosTuristicos[i].name)
            print(distanceInKilometers)
            if distanceInKilometers <= 3.0 {                PontosTuristicos[i].distancia = Distancias.tres
            } else if distanceInKilometers > 3.0 && distanceInKilometers <= 5.0 {
                PontosTuristicos[i].distancia = Distancias.cinco
            } else if distanceInKilometers > 5.0 && distanceInKilometers <= 10.0 {
                
                PontosTuristicos[i].distancia = Distancias.dez
            }
            
        }
    }
    
    func selecionarPontoTuristicoAleatorio() -> PontoTuristico? {
        
        
        let pontosFiltrados = PontosTuristicos.filter { ponto in
            var corresponde = true
            
            if selectedCategoria != Categorias.todos{
                if ponto.categoria != selectedCategoria {
                    corresponde = false
                }
            }
            
            if selectedPreco != Precos.todos {
                if ponto.preco != selectedPreco {
                    corresponde = false
                }
            }
            
            if selectedDistancia != Distancias.todos {
                if ponto.distancia != selectedDistancia {
                    corresponde = false
                }
            }
            
            return corresponde
        }
        
        return pontosFiltrados.randomElement()
    }
    
    private func addDesafio( pontoId: String ) {
        let player = GKLocalPlayer.local
        let newItem = Desafios(context: viewContext)
        newItem.id = UUID()
        newItem.data_lancado = Date()
        newItem.data_termino = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        newItem.ponto_id = pontoId
        newItem.user_id = player.gamePlayerID
        do {
            try viewContext.save()
            print(newItem)
        } catch {
        }
        
    }
    
}
