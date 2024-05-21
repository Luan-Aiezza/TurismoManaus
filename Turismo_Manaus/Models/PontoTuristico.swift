//
//  PontoTuristico.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 15/05/24.
//

import Foundation

class PontoTuristico {
    let id: UUID
    var name, desc, latitude, longitude, status: String
    let horarios: [String]
    var categoria: Categorias
    var preco: Precos
    var distancia: Distancias
    
    init(id: UUID, name: String, desc: String, categoria: Categorias, latitude: String, longitude: String, preco: Precos, horarios: [String], distancia: Distancias, status: String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.categoria = categoria
        self.latitude = latitude
        self.longitude = longitude
        self.preco = preco
        self.horarios = horarios
        self.distancia = distancia
        self.status = status
    }
}
