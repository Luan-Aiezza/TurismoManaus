//
//  PontoTuristico.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 15/05/24.
//

import Foundation

public class PontoTuristico {
    let id: UUID
    #warning("Muitas questions surgiram!")
    var name, desc, latitude, longitude, maps, status, endereco, link: String
    let horarios: [Horarios]
    var categoria: Categorias
    var preco: Precos
    var distancia: Distancias
    
    init(id: UUID, name: String, desc: String, categoria: Categorias, latitude: String, longitude: String, preco: Precos, horarios: [Horarios], distancia: Distancias, status: String, maps: String, endereco: String, link: String) {
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
        self.maps = maps
        self.endereco = endereco
        self.link = link
    }
}
