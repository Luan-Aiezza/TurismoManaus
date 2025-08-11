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
    @State var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    var body: some Scene {
        WindowGroup {
            if !hasCompletedOnboarding {
                OnboardingBase(hasCompletedOnboarding: $hasCompletedOnboarding)
            } else {
                UI()
            }
        }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        
    }
}
