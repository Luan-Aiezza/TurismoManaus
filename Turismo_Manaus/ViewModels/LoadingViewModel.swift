//
//  LoadingViewModel.swift
//  Turismo_Manaus
//
//  ViewModel para gerenciar o estado de loading da aplicação - Seguindo padrão MVVM
//

import Foundation
import SwiftUI
import Combine
import CoreData

@MainActor
class LoadingViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isLoading = true
    @Published var loadingProgress: Double = 0.0
    @Published var loadingMessage = "Carregando..."
    @Published var hasError = false
    @Published var errorMessage = ""
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let gameViewModel = GameCenterViewModel()
    
    // MARK: - Initialization
    init() {
        // Configurar observadores se necessário
    }
    
    // MARK: - Public Methods
    
    /// Executa a sequência de carregamento da aplicação
    func performInitialLoad() {
        Task {
            await executeLoadingSequence()
        }
    }
    
    /// Força um reload da aplicação
    func reload() {
        hasError = false
        errorMessage = ""
        isLoading = true
        loadingProgress = 0.0
        performInitialLoad()
    }
    
    // MARK: - Private Methods
    
    @MainActor
    private func executeLoadingSequence() async {
        do {
            updateLoadingState(progress: 0.1, message: "Inicializando aplicação...")
            
            // Simula inicialização de dados
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5 segundo
            updateLoadingState(progress: 0.3, message: "Carregando pontos turísticos...")
            
            // Carrega dados dos pontos turísticos
            try await Task.sleep(nanoseconds: 500_000_000)
            updateLoadingState(progress: 0.6, message: "Configurando Game Center...")
            
            // Autentica Game Center
            await authenticateGameCenter()
            updateLoadingState(progress: 0.8, message: "Verificando permissões...")
            
            // Finaliza carregamento
            try await Task.sleep(nanoseconds: 500_000_000)
            updateLoadingState(progress: 1.0, message: "Pronto!")
            
            // Pequena pausa antes de esconder loading
            try await Task.sleep(nanoseconds: 300_000_000)
            
            isLoading = false
            
        } catch {
            handleError(error)
        }
    }
    
    private func updateLoadingState(progress: Double, message: String) {
        loadingProgress = progress
        loadingMessage = message
    }
    
    private func authenticateGameCenter() async {
        // Game Center authentication é feita pelo GameCenterViewModel
        // Aqui apenas simulamos o tempo necessário
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 segundo
    }
    
    private func handleError(_ error: Error) {
        hasError = true
        errorMessage = error.localizedDescription
        isLoading = false
        
        print("Erro durante carregamento: \(error)")
    }
}

// MARK: - Loading States
extension LoadingViewModel {
    enum LoadingState {
        case idle
        case loading(message: String, progress: Double)
        case success
        case error(message: String)
    }
    
    var currentState: LoadingState {
        if hasError {
            return .error(message: errorMessage)
        } else if isLoading {
            return .loading(message: loadingMessage, progress: loadingProgress)
        } else {
            return .success
        }
    }
} 