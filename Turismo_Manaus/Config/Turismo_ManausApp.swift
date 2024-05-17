//
//  Turismo_ManausApp.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI

@main
struct Turismo_ManausApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
