//
//  PontoTuristico.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 15/05/24.
//

import Foundation
import SwiftUI

public class PontoTuristico {
    let id: UUID
    var name: String
    let imageName: ImageResource
    var desc, latitude, longitude, maps, status, endereco, link: String
    let horarios: [Horarios]
    var categoria: Categorias
    var preco: Precos
    
    init(id: UUID, name: String, imageName: ImageResource, desc: String, categoria: Categorias, latitude: String, longitude: String, preco: Precos, horarios: [Horarios], status: String, maps: String, endereco: String, link: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.desc = desc
        self.categoria = categoria
        self.latitude = latitude
        self.longitude = longitude
        self.preco = preco
        self.horarios = horarios
        self.status = status
        self.maps = maps
        self.endereco = endereco
        self.link = link
    }
}
