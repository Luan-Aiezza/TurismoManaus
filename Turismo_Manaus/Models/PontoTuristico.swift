//
//  PontoTuristico.swift
//  Turismo_Manaus
//
//  Refatorado para MVVM - Modelo principal de dados
//

import Foundation
import SwiftUI
import CoreLocation

struct PontoTuristico: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let imageName: String
    let description: String
    let categoria: Categories
    let coordinate: CLLocationCoordinate2D
    let preco: Prices
    let horarios: [Hours]
    let status: String
    let mapsUrl: String
    let endereco: String
    let websiteUrl: String
    
    // Computed property para distância (será calculada pelo ViewModel)
    var calculatedDistance: Double = 0.0
    
    // Computed property para filtro de distância
    var distanceCategory: Distances {
        switch calculatedDistance {
        case 0...1:
            return .umKm
        case 1...3:
            return .tresKm
        case 3...5:
            return .cincoKm
        case 5...10:
            return .dezKm
        default:
            return .dezKm
        }
    }
    
    init(id: UUID = UUID(), 
         name: String, 
         imageName: String, 
         description: String, 
         categoria: Categories, 
         latitude: Double, 
         longitude: Double, 
         preco: Prices, 
         horarios: [Hours], 
         status: String, 
         mapsUrl: String, 
         endereco: String, 
         websiteUrl: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.description = description
        self.categoria = categoria
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.preco = preco
        self.horarios = horarios
        self.status = status
        self.mapsUrl = mapsUrl
        self.endereco = endereco
        self.websiteUrl = websiteUrl
    }
    
    // MARK: - Computed Properties
    
    var isOpen: Bool {
        // Lógica para verificar se está aberto baseado nos horários
        // Por enquanto, retorna true se status não for "fechado"
        return status.lowercased() != "fechado"
    }
    
    var imageResource: ImageResource? {
        // Converte string para ImageResource se possível
        return ImageResource(name: imageName, bundle: .main)
    }
    
    var formattedDistance: String {
        if calculatedDistance < 1 {
            return String(format: "%.0f m", calculatedDistance * 1000)
        } else {
            return String(format: "%.1f km", calculatedDistance)
        }
    }
    
    // MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PontoTuristico, rhs: PontoTuristico) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case id, name, imageName, description, categoria, preco, horarios, status, mapsUrl, endereco, websiteUrl
        case latitude, longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageName = try container.decode(String.self, forKey: .imageName)
        description = try container.decode(String.self, forKey: .description)
        categoria = try container.decode(Categories.self, forKey: .categoria)
        preco = try container.decode(Prices.self, forKey: .preco)
        horarios = try container.decode([Hours].self, forKey: .horarios)
        status = try container.decode(String.self, forKey: .status)
        mapsUrl = try container.decode(String.self, forKey: .mapsUrl)
        endereco = try container.decode(String.self, forKey: .endereco)
        websiteUrl = try container.decode(String.self, forKey: .websiteUrl)
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(description, forKey: .description)
        try container.encode(categoria, forKey: .categoria)
        try container.encode(preco, forKey: .preco)
        try container.encode(horarios, forKey: .horarios)
        try container.encode(status, forKey: .status)
        try container.encode(mapsUrl, forKey: .mapsUrl)
        try container.encode(endereco, forKey: .endereco)
        try container.encode(websiteUrl, forKey: .websiteUrl)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
}
