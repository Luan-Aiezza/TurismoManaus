//
//  Turismo_ManausApp.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI

@main
struct Turismo_ManausApp: App {
    var body: some Scene {
        WindowGroup {
            Home(selectedCategoria: Categorias.todos, selectedHorario: Horarios.todos, selectedDistancia: Distancias.todos, selectedPreco: Precos.todos)
        }
    }
}
