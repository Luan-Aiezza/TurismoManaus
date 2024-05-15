//
//  PontoTurisco.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 15/05/24.
//

import Foundation

class PontoTurisco {
    var name, desc, categoria, latitude, longitude, horario, preco: String
    let id: Int
    
    init(name: String, desc: String, categoria: String, latitude: String, longitude: String, horario: String, preco: String, id: Int) {
        self.name = name
        self.desc = desc
        self.categoria = categoria
        self.latitude = latitude
        self.longitude = longitude
        self.horario = horario
        self.preco = preco
        self.id = id
    }
}
