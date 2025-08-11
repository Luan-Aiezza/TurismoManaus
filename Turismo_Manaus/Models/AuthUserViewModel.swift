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

class AuthUserViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var player = GKLocalPlayer.local
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default)
    private var desafios: FetchedResults<Desafios>
    
    func performTask() {
        // Simula uma tarefa demorada
        
        DispatchQueue.global().async {
            self.authenticateUser()
            sleep(2)
            // Espera 2 segundos para simular a tarefa
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
                let achievement = GKAchievement(identifier: "edificiotheoffice_1")
                achievement.percentComplete = 100
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement]) { error in
                    guard error == nil else {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    print("done!")
                }
                GKAccessPoint.shared.isActive = true
                self.player = player
            }
        }
        
    }
}
