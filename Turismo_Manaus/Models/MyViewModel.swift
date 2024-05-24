//
//  MyViewModel.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 23/05/24.
//

import Foundation
import SwiftUI
import Combine
import GameKit

class MyViewModel: ObservableObject {
    @Published var isLoading = true
    
    func performTask() {
        // Simula uma tarefa demorada
        DispatchQueue.global().async {
            self.authenticateUser() // Espera 2 segundos para simular a tarefa
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    private func authenticateUser() {
        let player = GKLocalPlayer.local
        player.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            if let vc = vc {
                // Present the Game Center view controller
                DispatchQueue.main.async {
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let window = scene.windows.first {
                            window.rootViewController?.present(vc, animated: true, completion: nil)
                        }
                    }
                }
            } else if player.isAuthenticated {
                // Player is authenticated
                print("Player authenticated!")
                GKAccessPoint.shared.location = .topLeading
                GKAccessPoint.shared.showHighlights = false
                GKAccessPoint.shared.isActive = true
                
                // You can perform additional actions here
            }
        }
    }
}
