//
//  LocationService.swift
//  Turismo_Manaus
//
//  Service para gerenciamento de localização - Seguindo padrão MVVM
//

import Foundation
import CoreLocation
import Combine

@MainActor
class LocationService: NSObject, ObservableObject {
    
    // MARK: - Published Properties
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var heading: Double = 0
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var isLocationServicesEnabled = false
    @Published var locationError: LocationError?
    @Published var isUpdatingLocation = false
    
    // MARK: - Private Properties
    private let locationManager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    var hasLocationPermission: Bool {
        return authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways
    }
    
    var latitude: Double {
        return currentLocation?.latitude ?? -3.1190 // Coordenada padrão de Manaus
    }
    
    var longitude: Double {
        return currentLocation?.longitude ?? -60.0217 // Coordenada padrão de Manaus
    }
    
    // MARK: - Initialization
    override init() {
        super.init()
        setupLocationManager()
        checkLocationServicesStatus()
    }
    
    // MARK: - Public Methods
    
    /// Solicita permissão de localização
    func requestLocationPermission() {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            locationError = .permissionDenied
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        @unknown default:
            locationError = .unknown
        }
    }
    
    /// Inicia atualizações de localização
    func startLocationUpdates() {
        guard hasLocationPermission else {
            requestLocationPermission()
            return
        }
        
        guard CLLocationManager.locationServicesEnabled() else {
            locationError = .locationServicesDisabled
            return
        }
        
        isUpdatingLocation = true
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    /// Para atualizações de localização
    func stopLocationUpdates() {
        isUpdatingLocation = false
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    
    /// Solicita localização única
    func requestSingleLocation() {
        guard hasLocationPermission else {
            requestLocationPermission()
            return
        }
        
        isUpdatingLocation = true
        locationManager.requestLocation()
    }
    
    /// Calcula distância entre dois pontos
    func distancia(para coordenada: CLLocationCoordinate2D) -> Double {
        guard let currentLocation = currentLocation else { return 0 }
        
        let location1 = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let location2 = CLLocation(latitude: coordenada.latitude, longitude: coordenada.longitude)
        
        return location1.distance(from: location2) / 1000 // Retorna em quilômetros
    }
    
    /// Formata distância para exibição
    func formatarDistancia(para coordenada: CLLocationCoordinate2D) -> String {
        let distanciaKm = distancia(para: coordenada)
        
        if distanciaKm < 1 {
            return String(format: "%.0f m", distanciaKm * 1000)
        } else if distanciaKm < 10 {
            return String(format: "%.1f km", distanciaKm)
        } else {
            return String(format: "%.0f km", distanciaKm)
        }
    }
    
    /// Limpa erros de localização
    func clearLocationError() {
        locationError = nil
    }
    
    // MARK: - Private Methods
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10 // Atualiza a cada 10 metros
        
        authorizationStatus = locationManager.authorizationStatus
        isLocationServicesEnabled = CLLocationManager.locationServicesEnabled()
    }
    
    private func checkLocationServicesStatus() {
        isLocationServicesEnabled = CLLocationManager.locationServicesEnabled()
        
        if !isLocationServicesEnabled {
            locationError = .locationServicesDisabled
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        currentLocation = location.coordinate
        isUpdatingLocation = false
        locationError = nil
        
        print("Localização atualizada: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading.trueHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isUpdatingLocation = false
        
        if let clError = error as? CLError {
            switch clError.code {
            case .denied:
                locationError = .permissionDenied
            case .locationUnknown:
                locationError = .locationUnavailable
            case .network:
                locationError = .networkError
            default:
                locationError = .unknown
            }
        } else {
            locationError = .unknown
        }
        
        print("Erro de localização: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        case .denied, .restricted:
            locationError = .permissionDenied
        case .notDetermined:
            break
        @unknown default:
            locationError = .unknown
        }
    }
}

// MARK: - LocationError
enum LocationError: LocalizedError {
    case permissionDenied
    case locationServicesDisabled
    case locationUnavailable
    case networkError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .permissionDenied:
            return "Permissão de localização negada. Ative nas configurações."
        case .locationServicesDisabled:
            return "Serviços de localização desabilitados."
        case .locationUnavailable:
            return "Localização não disponível no momento."
        case .networkError:
            return "Erro de rede ao obter localização."
        case .unknown:
            return "Erro desconhecido ao obter localização."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .permissionDenied:
            return "Vá para Configurações > Privacidade > Serviços de Localização e permita o acesso."
        case .locationServicesDisabled:
            return "Ative os serviços de localização nas configurações do dispositivo."
        case .locationUnavailable:
            return "Tente novamente em alguns momentos."
        case .networkError:
            return "Verifique sua conexão com a internet."
        case .unknown:
            return "Tente reiniciar o aplicativo."
        }
    }
} 