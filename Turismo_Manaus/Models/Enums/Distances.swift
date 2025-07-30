//
//  Distances.swift
//  Turismo_Manaus
//
//  Refatorado para MVVM - Enum para distâncias
//

import Foundation

enum Distances: String, CaseIterable, Identifiable {
    case todos = "todos"
    case umKm = "1km"
    case tresKm = "3km"
    case cincoKm = "5km"
    case dezKm = "10km"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .todos:
            return "Qualquer Distância"
        case .umKm:
            return "Até 1 km"
        case .tresKm:
            return "Até 3 km"
        case .cincoKm:
            return "Até 5 km"
        case .dezKm:
            return "Até 10 km"
        }
    }
    
    var icon: String {
        switch self {
        case .todos:
            return "location"
        case .umKm:
            return "figure.walk"
        case .tresKm:
            return "bicycle"
        case .cincoKm:
            return "car"
        case .dezKm:
            return "car.fill"
        }
    }
    
    var maxDistanceInKm: Double {
        switch self {
        case .todos:
            return Double.infinity
        case .umKm:
            return 1.0
        case .tresKm:
            return 3.0
        case .cincoKm:
            return 5.0
        case .dezKm:
            return 10.0
        }
    }
    
    var transportSuggestion: String {
        switch self {
        case .todos:
            return "Qualquer meio"
        case .umKm:
            return "A pé"
        case .tresKm:
            return "Bicicleta/Caminhada"
        case .cincoKm:
            return "Carro/Transporte"
        case .dezKm:
            return "Carro/Transporte"
        }
    }
} 