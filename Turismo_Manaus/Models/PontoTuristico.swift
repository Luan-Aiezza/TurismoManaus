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
    let horarios: [Hours]
    var categoria: Categories
    var distance: Distances = .todos
    var preco: Prices
    
    init(id: UUID, name: String, imageName: ImageResource, desc: String, categoria: Categories, latitude: String, longitude: String, preco: Prices, horarios: [Hours], status: String, maps: String, endereco: String, link: String) {
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
