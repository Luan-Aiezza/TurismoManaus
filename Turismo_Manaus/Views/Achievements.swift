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
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
            GameCenterAchievementsViewControllerWrapper()
                .onAppear{
                    addItem()
                }
        
        }
    private func addItem() {
        let player = GKLocalPlayer.local
            let newItem = Pontos_Visitados(context: viewContext)
            newItem.id = UUID()
            newItem.quant_idas = 1
            newItem.user_id = player.teamPlayerID
            print(newItem)
            do {
                try viewContext.save()
                print(newItem)
                unlockAchievement()
            } catch {
            }
        
    }
    private func unlockAchievement() {
            let achievement = GKAchievement(identifier: "cigs_1")
            achievement.percentComplete = 100
            achievement.showsCompletionBanner = true
            GKAchievement.report([achievement]) { error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                print("done!")
            }
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
