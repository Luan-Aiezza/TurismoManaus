//
//  Color+Extensions.swift
//  Turismo_Manaus
//
//  Extensões para cores personalizadas - Organização MVVM
//

import SwiftUI

extension Color {
    
    // MARK: - App Colors
    static let backgroundColor = Color.black
    static let accentColorYellow = Color("accentColorYellow")
    
    // MARK: - Glass Colors
    static let bgGlass1 = Color("bgGlass1")
    static let bgGlass2 = Color("bgGlass2")
    static let bgGlass3 = Color("bgGlass3")
    static let redGlass = Color("redGlass")
    
    // MARK: - Filter Colors
    static let fundofiltro = Color("Fundofiltro")
    static let fundofiltroInv = Color("FundofiltroInv")
    
    // MARK: - Neutral Colors
    static let neutral = Color("neutral")
    static let neutral2 = Color("neutral2")
    
    // MARK: - Action Colors
    static let greenButton = Color("greenButton")
    
    // MARK: - Convenience Methods
    
    /// Retorna uma cor com opacidade aplicada
    static func glass(_ opacity: Double = 0.3) -> Color {
        return bgGlass1.opacity(opacity)
    }
    
    /// Cores para diferentes categorias
    static func categoryColor(for category: Categories) -> Color {
        switch category {
        case .todos:
            return .gray
        case .tradicionais:
            return .purple
        case .culinaria:
            return .orange
        case .festas:
            return .pink
        }
    }
    
    /// Cores para diferentes preços
    static func priceColor(for price: Prices) -> Color {
        switch price {
        case .todos:
            return .gray
        case .gratuito:
            return .green
        case .barato:
            return .blue
        case .medio:
            return .orange
        case .caro:
            return .red
        }
    }
    
    /// Cores para diferentes distâncias
    static func distanceColor(for distance: Distances) -> Color {
        switch distance {
        case .todos:
            return .gray
        case .umKm:
            return .green
        case .tresKm:
            return .blue
        case .cincoKm:
            return .orange
        case .dezKm:
            return .red
        }
    }
}

// MARK: - Theme Colors
extension Color {
    
    static let theme = Theme()
    
    struct Theme {
        let primary = Color.accentColorYellow
        let secondary = Color.bgGlass1
        let background = Color.backgroundColor
        let surface = Color.bgGlass2
        let error = Color.red
        let success = Color.green
        let warning = Color.orange
        let info = Color.blue
        
        // Text colors
        let textPrimary = Color.white
        let textSecondary = Color.white.opacity(0.7)
        let textTertiary = Color.white.opacity(0.5)
        
        // Gradient colors
        var primaryGradient: LinearGradient {
            LinearGradient(
                colors: [primary, primary.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
        
        var backgroundGradient: LinearGradient {
            LinearGradient(
                colors: [background, background.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
} 