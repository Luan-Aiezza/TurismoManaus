//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI
import GameKit
struct Achievements: View {
    @State private var selectedTab: Int = 1
    
    var body: some View {
        //ZStack define a ordem dos itens na layer
        GameCenterAchievementsViewControllerWrapper()
            
        }
    }


#Preview {
    Achievements()
}



struct GameCenterAchievementsViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = GKGameCenterViewController(state: .achievements)
        viewController.gameCenterDelegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No update needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, GKGameCenterControllerDelegate {
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
    }
}
