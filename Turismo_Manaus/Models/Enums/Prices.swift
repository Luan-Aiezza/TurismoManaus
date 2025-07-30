//
//  Prices.swift
//  Turismo_Manaus
//
//  Refatorado para MVVM - Enum para faixas de preço
//

import Foundation

enum Prices: String, CaseIterable, Identifiable {
    case todos = "todos"
    case gratuito = "gratuito"
    case barato = "barato"
    case medio = "medio"
    case caro = "caro"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .todos:
            return "Todas as Faixas"
        case .gratuito:
            return "Gratuito"
        case .barato:
            return "Até R$ 20"
        case .medio:
            return "R$ 20 - R$ 50"
        case .caro:
            return "Acima de R$ 50"
        }
    }
    
    var icon: String {
        switch self {
        case .todos:
            return "creditcard"
        case .gratuito:
            return "gift"
        case .barato:
            return "dollarsign.circle"
        case .medio:
            return "dollarsign.circle.fill"
        case .caro:
            return "diamond"
        }
    }
    
    var priceRange: String {
        switch self {
        case .todos:
            return "R$ 0 - ∞"
        case .gratuito:
            return "R$ 0"
        case .barato:
            return "R$ 0 - R$ 20"
        case .medio:
            return "R$ 20 - R$ 50"
        case .caro:
            return "R$ 50+"
        }
    }
    
    var color: String {
        switch self {
        case .todos:
            return "gray"
        case .gratuito:
            return "green"
        case .barato:
            return "blue"
        case .medio:
            return "orange"
        case .caro:
            return "red"
        }
    }
} 