//
//  DataService.swift
//  Turismo_Manaus
//
//  Service para gerenciamento de dados - Seguindo padrão MVVM
//

import Foundation
import Combine
import CoreData

@MainActor
class DataService: ObservableObject {
    
    // MARK: - Published Properties
    @Published var pontosTuristicos: [PontoTuristico] = []
    @Published var isLoading = false
    @Published var error: DataError?
    @Published var lastUpdated: Date?
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    var pontosDisponiveis: [PontoTuristico] {
        return pontosTuristicos.filter { ponto in
            ponto.status.lowercased() != "fechado" && 
            ponto.status.lowercased() != "indisponivel"
        }
    }
    
    var categorias: [Categories] {
        let categoriasUnicas = Set(pontosTuristicos.map { $0.categoria })
        return Array(categoriasUnicas).sorted { $0.rawValue < $1.rawValue }
    }
    
    // MARK: - Initialization
    init() {
        loadInitialData()
    }
    
    // MARK: - Public Methods
    
    /// Carrega dados iniciais
    func loadInitialData() {
        isLoading = true
        error = nil
        
        // Por enquanto, carrega os dados estáticos
        // No futuro, pode ser modificado para carregar de uma API
        pontosTuristicos = PontosTuristicos
        lastUpdated = Date()
        isLoading = false
    }
    
    /// Recarrega todos os dados
    func reloadData() {
        loadInitialData()
    }
    
    /// Busca pontos por categoria
    func pontos(por categoria: Categories) -> [PontoTuristico] {
        if categoria == .todos {
            return pontosDisponiveis
        }
        return pontosDisponiveis.filter { $0.categoria == categoria }
    }
    
    /// Busca pontos por preço
    func pontos(por preco: Prices) -> [PontoTuristico] {
        if preco == .todos {
            return pontosDisponiveis
        }
        return pontosDisponiveis.filter { $0.preco == preco }
    }
    
    /// Busca ponto por ID
    func ponto(comId id: UUID) -> PontoTuristico? {
        return pontosTuristicos.first { $0.id == id }
    }
    
    /// Busca pontos próximos a uma coordenada
    func pontosProximos(
        latitude: Double, 
        longitude: Double, 
        raioKm: Double = 5.0
    ) -> [PontoTuristico] {
        
        return pontosDisponiveis.filter { ponto in
            let distancia = calcularDistancia(
                de: (latitude, longitude),
                para: (ponto.coordinate.latitude, ponto.coordinate.longitude)
            )
            return distancia <= raioKm
        }.sorted { ponto1, ponto2 in
            let dist1 = calcularDistancia(
                de: (latitude, longitude),
                para: (ponto1.coordinate.latitude, ponto1.coordinate.longitude)
            )
            let dist2 = calcularDistancia(
                de: (latitude, longitude),
                para: (ponto2.coordinate.latitude, ponto2.coordinate.longitude)
            )
            return dist1 < dist2
        }
    }
    
    /// Pesquisa pontos por termo
    func pesquisar(termo: String) -> [PontoTuristico] {
        if termo.isEmpty {
            return pontosDisponiveis
        }
        
        let termoLowercase = termo.lowercased()
        return pontosDisponiveis.filter { ponto in
            ponto.name.lowercased().contains(termoLowercase) ||
            ponto.description.lowercased().contains(termoLowercase) ||
            ponto.endereco.lowercased().contains(termoLowercase)
        }
    }
    
    /// Atualiza distâncias calculadas para todos os pontos
    func atualizarDistancias(
        latitudeUsuario: Double, 
        longitudeUsuario: Double
    ) {
        for i in 0..<pontosTuristicos.count {
            let distancia = calcularDistancia(
                de: (latitudeUsuario, longitudeUsuario),
                para: (pontosTuristicos[i].coordinate.latitude, pontosTuristicos[i].coordinate.longitude)
            )
            pontosTuristicos[i].calculatedDistance = distancia
        }
    }
    
    /// Salva dados no Core Data (se necessário)
    func salvarDados(context: NSManagedObjectContext) {
        // Implementação para salvar dados se necessário
        // Por enquanto, os dados são estáticos
    }
    
    /// Limpa cache de dados
    func limparCache() {
        pontosTuristicos.removeAll()
        lastUpdated = nil
        error = nil
    }
    
    // MARK: - Private Methods
    
    private func calcularDistancia(
        de origem: (latitude: Double, longitude: Double),
        para destino: (latitude: Double, longitude: Double)
    ) -> Double {
        
        let R = 6371.0 // Raio da Terra em km
        
        let lat1Rad = origem.latitude * .pi / 180
        let lat2Rad = destino.latitude * .pi / 180
        let deltaLatRad = (destino.latitude - origem.latitude) * .pi / 180
        let deltaLonRad = (destino.longitude - origem.longitude) * .pi / 180
        
        let a = sin(deltaLatRad/2) * sin(deltaLatRad/2) +
                cos(lat1Rad) * cos(lat2Rad) *
                sin(deltaLonRad/2) * sin(deltaLonRad/2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        
        return R * c
    }
    
    private func handleError(_ error: Error) {
        self.error = .loadingFailed(error.localizedDescription)
        self.isLoading = false
    }
}

// MARK: - DataError
enum DataError: LocalizedError {
    case loadingFailed(String)
    case networkError
    case parsingError
    case noDataAvailable
    
    var errorDescription: String? {
        switch self {
        case .loadingFailed(let message):
            return "Falha ao carregar dados: \(message)"
        case .networkError:
            return "Erro de conexão. Verifique sua internet."
        case .parsingError:
            return "Erro ao processar dados."
        case .noDataAvailable:
            return "Nenhum dado disponível."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .loadingFailed:
            return "Tente novamente ou reinicie o aplicativo."
        case .networkError:
            return "Verifique sua conexão e tente novamente."
        case .parsingError:
            return "Aguarde uma atualização do aplicativo."
        case .noDataAvailable:
            return "Atualize a lista ou tente novamente mais tarde."
        }
    }
}

// MARK: - Extensions
extension DataService {
    
    /// Estatísticas dos dados
    var estatisticas: DataStatistics {
        return DataStatistics(
            totalPontos: pontosTuristicos.count,
            pontosDisponiveis: pontosDisponiveis.count,
            categorias: categorias.count,
            ultimaAtualizacao: lastUpdated
        )
    }
}

struct DataStatistics {
    let totalPontos: Int
    let pontosDisponiveis: Int
    let categorias: Int
    let ultimaAtualizacao: Date?
    
    var percentualDisponiveis: Double {
        guard totalPontos > 0 else { return 0 }
        return Double(pontosDisponiveis) / Double(totalPontos) * 100
    }
} 