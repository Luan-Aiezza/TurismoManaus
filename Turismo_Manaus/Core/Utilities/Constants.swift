//
//  Constants.swift
//  Turismo_Manaus
//
//  Constantes e configurações globais - Organização MVVM
//

import Foundation
import CoreLocation

// MARK: - App Constants
struct AppConstants {
    
    // MARK: - Location
    struct Location {
        static let manausDefaultLatitude: Double = -3.1190
        static let manausDefaultLongitude: Double = -60.0217
        static let defaultLocationAccuracy: Double = 10.0 // metros
        static let maxLocationRadius: Double = 50.0 // km
        
        static let defaultCoordinate = CLLocationCoordinate2D(
            latitude: manausDefaultLatitude,
            longitude: manausDefaultLongitude
        )
    }
    
    // MARK: - UI
    struct UI {
        static let cornerRadius: CGFloat = 12.0
        static let smallCornerRadius: CGFloat = 8.0
        static let largeCornerRadius: CGFloat = 20.0
        
        static let defaultPadding: CGFloat = 16.0
        static let smallPadding: CGFloat = 8.0
        static let largePadding: CGFloat = 24.0
        
        static let cardWidth: CGFloat = 300.0
        static let cardHeight: CGFloat = 200.0
        
        static let buttonHeight: CGFloat = 44.0
        static let iconSize: CGFloat = 24.0
        
        // Animation durations
        static let shortAnimation: Double = 0.2
        static let mediumAnimation: Double = 0.3
        static let longAnimation: Double = 0.5
    }
    
    // MARK: - Data
    struct Data {
        static let maxCacheAge: TimeInterval = 300 // 5 minutos
        static let requestTimeout: TimeInterval = 30.0
        static let maxRetryAttempts = 3
    }
    
    // MARK: - GameCenter
    struct GameCenter {
        static let achievementPrefix = "com.turismanaus."
        static let leaderboardPrefix = "com.turismanaus.leaderboard."
        
        // Achievement IDs
        static let firstVisitAchievement = "edificiotheoffice_1"
        static let explorerAchievement = "explorer_achievement"
        static let completionistAchievement = "completionist"
    }
    
    // MARK: - Challenges
    struct Challenges {
        static let defaultDuration: TimeInterval = 7 * 24 * 60 * 60 // 7 dias
        static let maxActiveChallenges = 5
        static let completionReward = 100 // pontos
    }
    
    // MARK: - Filters
    struct Filters {
        static let maxDistance: Double = 50.0 // km
        static let defaultDistance: Double = 5.0 // km
        static let distanceSteps: [Double] = [1.0, 3.0, 5.0, 10.0]
    }
}

// MARK: - Environment
enum Environment {
    case development
    case staging
    case production
    
    static var current: Environment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://dev-api.turismanaus.com"
        case .staging:
            return "https://staging-api.turismanaus.com"
        case .production:
            return "https://api.turismanaus.com"
        }
    }
}

// MARK: - Feature Flags
struct FeatureFlags {
    static let enableLocationServices = true
    static let enableGameCenter = true
    static let enableChallenges = true
    static let enableAnalytics = false
    static let enableDebugMode = Environment.current == .development
    static let enableOfflineMode = true
}

// MARK: - Strings
struct Strings {
    
    struct Common {
        static let appName = "Turismo Manaus"
        static let loading = "Carregando..."
        static let error = "Erro"
        static let retry = "Tentar Novamente"
        static let cancel = "Cancelar"
        static let ok = "OK"
        static let done = "Concluído"
        static let next = "Próximo"
        static let previous = "Anterior"
        static let save = "Salvar"
        static let delete = "Excluir"
        static let edit = "Editar"
        static let search = "Pesquisar"
        static let filter = "Filtrar"
        static let clear = "Limpar"
        static let apply = "Aplicar"
    }
    
    struct Location {
        static let permissionTitle = "Permissão de Localização"
        static let permissionMessage = "Para mostrar pontos próximos a você, precisamos acessar sua localização."
        static let settingsButton = "Configurações"
        static let notNowButton = "Agora Não"
        static let locationDisabled = "Serviços de localização desabilitados"
        static let locationUnavailable = "Localização não disponível"
    }
    
    struct Filters {
        static let activeFilters = "Filtros Ativos"
        static let noFiltersActive = "Nenhum filtro ativo"
        static let clearAll = "Limpar Tudo"
        static let quickFilters = "Filtros Rápidos"
        static let category = "Categoria"
        static let price = "Preço"
        static let distance = "Distância"
        static let hours = "Horário"
    }
    
    struct Challenges {
        static let newChallenge = "Novo Desafio!"
        static let challengeAccepted = "Desafio Aceito"
        static let challengeCompleted = "Desafio Concluído"
        static let challengeExpired = "Desafio Expirado"
        static let noChallengesActive = "Nenhum desafio ativo"
        static let acceptChallenge = "Aceitar Desafio"
        static let declineChallenge = "Recusar"
    }
}

// MARK: - Formatters
extension AppConstants {
    
    struct Formatters {
        static let distance: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 1
            formatter.minimumFractionDigits = 0
            return formatter
        }()
        
        static let currency: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "BRL"
            formatter.locale = Locale(identifier: "pt_BR")
            return formatter
        }()
        
        static let date: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.locale = Locale(identifier: "pt_BR")
            return formatter
        }()
    }
} 