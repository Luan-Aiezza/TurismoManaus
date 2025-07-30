//
//  LocationViewModel.swift
//  Turismo_Manaus
//
//  Refatorada para MVVM - Usa LocationService para delegação
//

import Foundation
import CoreLocation
import Combine

@MainActor
public class LocationViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var pontoSelecionado: PontoTuristico?
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var log: String = ""
    
    // MARK: - Private Properties
    private let locationService = LocationService()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    var hasLocationPermission: Bool {
        locationService.hasLocationPermission
    }
    
    var isLocationServicesEnabled: Bool {
        locationService.isLocationServicesEnabled
    }
    
    var currentLocation: CLLocationCoordinate2D? {
        locationService.currentLocation
    }
    
    // MARK: - Initialization
    public init(pontoSelecionado: PontoTuristico? = nil) {
        self.pontoSelecionado = pontoSelecionado
        setupObservers()
        locationService.requestLocationPermission()
    }
    
    // MARK: - Public Methods
    
    /// Solicita permissão de localização
    func requestLocationPermission() {
        locationService.requestLocationPermission()
    }
    
    /// Inicia atualizações de localização
    func startLocationUpdates() {
        locationService.startLocationUpdates()
    }
    
    /// Para atualizações de localização
    func stopLocationUpdates() {
        locationService.stopLocationUpdates()
    }
    
    /// Solicita localização única
    func requestSingleLocation() {
        locationService.requestSingleLocation()
    }
    
    /// Calcula distância para um ponto turístico
    func distancia(para ponto: PontoTuristico) -> Double {
        return locationService.distancia(para: ponto.coordinate)
    }
    
    /// Formata distância para exibição
    func distanciaFormatada(para ponto: PontoTuristico) -> String {
        return locationService.formatarDistancia(para: ponto.coordinate)
    }
    
    /// Limpa erros de localização
    func clearLocationError() {
        locationService.clearLocationError()
        log = ""
    }
    
    // MARK: - Private Methods
    
    private func setupObservers() {
        // Observa mudanças na localização atual
        locationService.$currentLocation
            .compactMap { $0 }
            .sink { [weak self] coordinate in
                self?.latitude = coordinate.latitude
                self?.longitude = coordinate.longitude
                self?.log = "Localização atualizada: \(coordinate.latitude), \(coordinate.longitude)"
            }
            .store(in: &cancellables)
        
        // Observa mudanças no status de autorização
        locationService.$authorizationStatus
            .sink { [weak self] status in
                self?.updateLogForAuthorizationStatus(status)
            }
            .store(in: &cancellables)
        
        // Observa erros de localização
        locationService.$locationError
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.log = error.localizedDescription
            }
            .store(in: &cancellables)
        
        // Observa status de loading
        locationService.$isUpdatingLocation
            .sink { [weak self] isUpdating in
                if isUpdating {
                    self?.log = "Atualizando localização..."
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateLogForAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            log = "Permissão de localização não determinada"
        case .restricted:
            log = "Permissão de localização restrita"
        case .denied:
            log = "Permissão de localização negada"
        case .authorizedAlways:
            log = "Permissão de localização sempre autorizada"
        case .authorizedWhenInUse:
            log = "Permissão de localização autorizada durante uso"
        @unknown default:
            log = "Status de autorização desconhecido"
        }
    }
}

// MARK: - Compatibility Extensions
extension LocationViewModel {
    
    /// Compatibilidade com código antigo - usa LocationService internamente
    var locationManager: CLLocationManager? {
        // Retorna nil para manter compatibilidade, mas agora usa LocationService
        return nil
    }
    
    /// Método de compatibilidade para inicialização antiga
    convenience init(locationManager: CLLocationManager = CLLocationManager(), pontoSelecionado: PontoTuristico? = nil) {
        self.init(pontoSelecionado: pontoSelecionado)
        // Ignora o locationManager passado, pois agora usa LocationService
    }
}
