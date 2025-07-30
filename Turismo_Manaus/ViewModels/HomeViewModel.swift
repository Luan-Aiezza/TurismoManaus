//
//  HomeViewModel.swift
//  Turismo_Manaus
//
//  ViewModel específico para a tela Home - Seguindo padrão MVVM
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import CoreData
import GameKit

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var selectedCategoria = Categories.todos
    @Published var selectedHorario = Hours.todos
    @Published var selectedDistancia = Distances.todos
    @Published var selectedPreco = Prices.todos
    @Published var isShowingFilterView = false
    @Published var isShowingModal = false
    @Published var pontoSelecionado: PontoTuristico?
    @Published var isLoading = false
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let locationViewModel: LocationViewModel
    private let gameViewModel = GameCenterViewModel()
    
    // MARK: - Computed Properties
    var pontosFiltrados: [PontoTuristico] {
        PontosTuristicos.filter { ponto in
            aplicarFiltros(para: ponto)
        }
    }
    
    // MARK: - Initialization
    init(locationViewModel: LocationViewModel) {
        self.locationViewModel = locationViewModel
        setupObservers()
    }
    
    // MARK: - Private Methods
    private func setupObservers() {
        // Observa mudanças na localização para recalcular distâncias
        locationViewModel.$latitude
            .combineLatest(locationViewModel.$longitude)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] _, _ in
                self?.calcularDistancias()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    
    /// Sorteia um ponto turístico baseado nos filtros aplicados
    func sortearPonto() {
        guard !pontosFiltrados.isEmpty else {
            print("Nenhum ponto disponível com os filtros aplicados")
            return
        }
        
        pontoSelecionado = pontosFiltrados.randomElement()
        isShowingModal = true
    }
    
    /// Aplica todos os filtros selecionados a um ponto turístico
    private func aplicarFiltros(para ponto: PontoTuristico) -> Bool {
        // Filtro de categoria
        if selectedCategoria != .todos && ponto.categoria != selectedCategoria {
            return false
        }
        
        // Filtro de preço
        if selectedPreco != .todos && ponto.preco != selectedPreco {
            return false
        }
        
        // Filtro de distância
        if selectedDistancia != .todos && ponto.distanceCategory != selectedDistancia {
            return false
        }
        
        // Filtro de horário (implementação básica)
        if selectedHorario != .todos {
            // Por enquanto, aceita todos os horários
            // Pode ser implementada lógica mais específica baseada nos horários do ponto
        }
        
        return true
    }
    
    /// Calcula as distâncias de todos os pontos turísticos em relação à localização atual
    func calcularDistancias() {
        let userLocation = CLLocation(
            latitude: locationViewModel.latitude,
            longitude: locationViewModel.longitude
        )
        
        for i in 0..<PontosTuristicos.count {
            let pontoLocation = CLLocation(
                latitude: PontosTuristicos[i].coordinate.latitude,
                longitude: PontosTuristicos[i].coordinate.longitude
            )
            
            let distanceInMeters = userLocation.distance(from: pontoLocation)
            let distanceInKilometers = distanceInMeters / 1000
            
            // Atualiza a distância calculada do ponto
            PontosTuristicos[i].calculatedDistance = distanceInKilometers
        }
    }
    
    /// Adiciona um novo desafio ao Core Data
    func adicionarDesafio(ponto: PontoTuristico, context: NSManagedObjectContext) {
        let player = GKLocalPlayer.local
        let newDesafio = Desafios(context: context)
        
        newDesafio.id = UUID()
        newDesafio.data_lancado = Date()
        newDesafio.data_termino = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        newDesafio.ponto_id = transformarStringParaId(ponto.name)
        newDesafio.user_id = player.gamePlayerID
        newDesafio.state = "inProgress"
        
        do {
            try context.save()
            print("Desafio criado com sucesso: \(ponto.name)")
        } catch {
            print("Erro ao salvar desafio: \(error)")
        }
    }
    
    /// Aceita um desafio e fecha o modal
    func aceitarDesafio(context: NSManagedObjectContext) {
        guard let ponto = pontoSelecionado else { return }
        
        adicionarDesafio(ponto: ponto, context: context)
        isShowingModal = false
        pontoSelecionado = nil
    }
    
    /// Recusa um desafio e fecha o modal
    func recusarDesafio() {
        isShowingModal = false
        pontoSelecionado = nil
    }
    
    /// Limpa todos os filtros
    func limparFiltros() {
        selectedCategoria = .todos
        selectedHorario = .todos
        selectedDistancia = .todos
        selectedPreco = .todos
    }
    
    /// Transforma o nome do ponto em um ID padronizado
    private func transformarStringParaId(_ input: String) -> String {
        return input.lowercased()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "á", with: "a")
            .replacingOccurrences(of: "à", with: "a")
            .replacingOccurrences(of: "ã", with: "a")
            .replacingOccurrences(of: "â", with: "a")
            .replacingOccurrences(of: "ç", with: "c")
            .replacingOccurrences(of: "é", with: "e")
            .replacingOccurrences(of: "ê", with: "e")
            .replacingOccurrences(of: "í", with: "i")
            .replacingOccurrences(of: "ó", with: "o")
            .replacingOccurrences(of: "ô", with: "o")
            .replacingOccurrences(of: "õ", with: "o")
            .replacingOccurrences(of: "ú", with: "u")
            .replacingOccurrences(of: "ü", with: "u")
    }
}

// MARK: - Game Center ViewModel (Separado para responsabilidade única)
@MainActor
class GameCenterViewModel: ObservableObject {
    @Published var player = GKLocalPlayer.local
    @Published var isAuthenticated = false
    
    init() {
        authenticateUser()
    }
    
    private func authenticateUser() {
        let player = GKLocalPlayer.local
        player.authenticateHandler = { [weak self] vc, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Game Center authentication error: \(error?.localizedDescription ?? "")")
                    return
                }
                
                if let vc = vc {
                    // Present the Game Center view controller if needed
                    self?.presentViewController(vc)
                } else if player.isAuthenticated {
                    self?.configureGameCenter()
                    self?.isAuthenticated = true
                }
            }
        }
    }
    
    private func presentViewController(_ viewController: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController?.present(viewController, animated: true)
        }
    }
    
    private func configureGameCenter() {
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.showHighlights = false
        GKAccessPoint.shared.isActive = true
        
        // Report achievement example
        let achievement = GKAchievement(identifier: "edificiotheoffice_1")
        achievement.percentComplete = 100
        achievement.showsCompletionBanner = true
        
        GKAchievement.report([achievement]) { error in
            if let error = error {
                print("Achievement report error: \(error.localizedDescription)")
            } else {
                print("Achievement reported successfully!")
            }
        }
    }
} 