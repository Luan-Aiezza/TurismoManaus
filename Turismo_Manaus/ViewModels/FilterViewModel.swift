//
//  FilterViewModel.swift
//  Turismo_Manaus
//
//  ViewModel específico para gerenciar filtros - Seguindo padrão MVVM
//

import Foundation
import SwiftUI
import Combine

@MainActor
class FilterViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var selectedCategoria = Categories.todos
    @Published var selectedHorario = Hours.todos
    @Published var selectedDistancia = Distances.todos
    @Published var selectedPreco = Prices.todos
    @Published var isShowingFilterView = false
    
    // MARK: - Computed Properties
    
    /// Verifica se existem filtros ativos
    var hasActiveFilters: Bool {
        return selectedCategoria != .todos ||
               selectedHorario != .todos ||
               selectedDistancia != .todos ||
               selectedPreco != .todos
    }
    
    /// Número de filtros ativos
    var activeFiltersCount: Int {
        var count = 0
        if selectedCategoria != .todos { count += 1 }
        if selectedHorario != .todos { count += 1 }
        if selectedDistancia != .todos { count += 1 }
        if selectedPreco != .todos { count += 1 }
        return count
    }
    
    /// Descrição resumida dos filtros ativos
    var activeFiltersDescription: String {
        var descriptions: [String] = []
        
        if selectedCategoria != .todos {
            descriptions.append(selectedCategoria.displayName)
        }
        if selectedHorario != .todos {
            descriptions.append(selectedHorario.displayName)
        }
        if selectedDistancia != .todos {
            descriptions.append(selectedDistancia.displayName)
        }
        if selectedPreco != .todos {
            descriptions.append(selectedPreco.displayName)
        }
        
        if descriptions.isEmpty {
            return "Nenhum filtro ativo"
        }
        
        return descriptions.joined(separator: " • ")
    }
    
    // MARK: - Public Methods
    
    /// Aplica filtros a uma lista de pontos turísticos
    func aplicarFiltros(a pontos: [PontoTuristico]) -> [PontoTuristico] {
        return pontos.filter { ponto in
            return verificarFiltroCategoria(ponto) &&
                   verificarFiltroHorario(ponto) &&
                   verificarFiltroDistancia(ponto) &&
                   verificarFiltroPreco(ponto)
        }
    }
    
    /// Limpa todos os filtros
    func limparFiltros() {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedCategoria = .todos
            selectedHorario = .todos
            selectedDistancia = .todos
            selectedPreco = .todos
        }
    }
    
    /// Aplica filtros pré-definidos
    func aplicarFiltroRapido(_ tipo: FiltroRapido) {
        withAnimation(.easeInOut(duration: 0.3)) {
            switch tipo {
            case .pertoDeMim:
                selectedDistancia = .tresKm
            case .gratuito:
                selectedPreco = .gratuito
            case .culinaria:
                selectedCategoria = .culinaria
            case .pontosTradicionais:
                selectedCategoria = .tradicionais
            case .abertosAgora:
                selectedHorario = determinarHorarioAtual()
            }
        }
    }
    
    /// Salva o estado atual dos filtros
    func salvarEstadoFiltros() -> FilterState {
        return FilterState(
            categoria: selectedCategoria,
            horario: selectedHorario,
            distancia: selectedDistancia,
            preco: selectedPreco
        )
    }
    
    /// Restaura um estado salvo dos filtros
    func restaurarEstadoFiltros(_ estado: FilterState) {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedCategoria = estado.categoria
            selectedHorario = estado.horario
            selectedDistancia = estado.distancia
            selectedPreco = estado.preco
        }
    }
    
    // MARK: - Private Methods
    
    private func verificarFiltroCategoria(_ ponto: PontoTuristico) -> Bool {
        return selectedCategoria == .todos || ponto.categoria == selectedCategoria
    }
    
    private func verificarFiltroHorario(_ ponto: PontoTuristico) -> Bool {
        if selectedHorario == .todos {
            return true
        }
        
        // Lógica básica - pode ser expandida com horários reais dos pontos
        return ponto.horarios.contains(selectedHorario) || ponto.horarios.contains(.todos)
    }
    
    private func verificarFiltroDistancia(_ ponto: PontoTuristico) -> Bool {
        if selectedDistancia == .todos {
            return true
        }
        
        let pontoCategoriaDistancia = ponto.distanceCategory
        
        // Verifica se a distância do ponto está dentro do filtro selecionado
        switch selectedDistancia {
        case .todos:
            return true
        case .umKm:
            return pontoCategoriaDistancia == .umKm
        case .tresKm:
            return pontoCategoriaDistancia == .umKm || pontoCategoriaDistancia == .tresKm
        case .cincoKm:
            return pontoCategoriaDistancia != .dezKm
        case .dezKm:
            return true // Qualquer distância até 10km
        }
    }
    
    private func verificarFiltroPreco(_ ponto: PontoTuristico) -> Bool {
        return selectedPreco == .todos || ponto.preco == selectedPreco
    }
    
    private func determinarHorarioAtual() -> Hours {
        let horaAtual = Calendar.current.component(.hour, from: Date())
        
        switch horaAtual {
        case 6..<12:
            return .manha
        case 12..<18:
            return .tarde
        case 18..<24, 0..<6:
            return .noite
        default:
            return .todos
        }
    }
}

// MARK: - Supporting Types

struct FilterState {
    let categoria: Categories
    let horario: Hours
    let distancia: Distances
    let preco: Prices
}

enum FiltroRapido: String, CaseIterable {
    case pertoDeMim = "Perto de Mim"
    case gratuito = "Gratuito"
    case culinaria = "Culinária"
    case pontosTradicionais = "Pontos Tradicionais"
    case abertosAgora = "Abertos Agora"
    
    var icon: String {
        switch self {
        case .pertoDeMim:
            return "location.fill"
        case .gratuito:
            return "gift.fill"
        case .culinaria:
            return "fork.knife"
        case .pontosTradicionais:
            return "building.columns.fill"
        case .abertosAgora:
            return "clock.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .pertoDeMim:
            return .blue
        case .gratuito:
            return .green
        case .culinaria:
            return .orange
        case .pontosTradicionais:
            return .purple
        case .abertosAgora:
            return .yellow
        }
    }
} 