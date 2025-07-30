//
//  Hours.swift
//  Turismo_Manaus
//
//  Refatorado para MVVM - Enum para horários de funcionamento
//

import Foundation

enum Hours: String, CaseIterable, Identifiable {
    case todos = "todos"
    case manha = "manha"
    case tarde = "tarde"
    case noite = "noite"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .todos:
            return "Todos os Horários"
        case .manha:
            return "Manhã (6h - 12h)"
        case .tarde:
            return "Tarde (12h - 18h)"
        case .noite:
            return "Noite (18h - 24h)"
        }
    }
    
    var icon: String {
        switch self {
        case .todos:
            return "clock"
        case .manha:
            return "sun.max"
        case .tarde:
            return "sun.haze"
        case .noite:
            return "moon.stars"
        }
    }
    
    var timeRange: String {
        switch self {
        case .todos:
            return "24h"
        case .manha:
            return "06:00 - 12:00"
        case .tarde:
            return "12:00 - 18:00"
        case .noite:
            return "18:00 - 24:00"
        }
    }
} 