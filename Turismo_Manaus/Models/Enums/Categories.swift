//
//  Categories.swift
//  Turismo_Manaus
//
//  Refatorado para MVVM - Enum para categorias de pontos turísticos
//

import Foundation

enum Categories: String, CaseIterable, Identifiable {
    case todos = "todos"
    case tradicionais = "tradicionais"
    case culinaria = "culinaria"
    case festas = "festas"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .todos:
            return "Todos"
        case .tradicionais:
            return "Pontos Tradicionais"
        case .culinaria:
            return "Culinária"
        case .festas:
            return "Festas e Eventos"
        }
    }
    
    var icon: String {
        switch self {
        case .todos:
            return "list.bullet"
        case .tradicionais:
            return "building.columns"
        case .culinaria:
            return "fork.knife"
        case .festas:
            return "party.popper"
        }
    }
} 