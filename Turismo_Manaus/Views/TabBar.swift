//
//  TabBar.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 14/05/24.
//

import SwiftUI
import GameKit

enum Tabs: Int {
    case dice = 0
    case achievement = 1
    case ranking = 2
    case me = 3
}

struct TabBar: View {
    @State private var isPresentingGameCenter = false
    @State private var isPresentingGameCenter2 = false

    var body: some View {
        
        //        @State private var selectTab: Int = 0
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .frame(width: 358, height: 70) // Ajuste o tamanho conforme necessário
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack (alignment: .center, spacing: 40){
                Button(action: {
                }, label: {
                    VStack{
                        Image(systemName: "dice.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                        
                    }
                })
                
                Button(action: {
                    isPresentingGameCenter = true
                }, label: {
                    VStack{
                        Image(systemName: "rosette")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .tint(.gray)
                        
                    }
                    
                }).sheet(isPresented: $isPresentingGameCenter, onDismiss: {}) {
                    GameCenterAchievementsViewControllerWrapper()
                }
                
                Button(action: {
                    isPresentingGameCenter2 = true
                }, label: {
                    VStack (alignment: .center, spacing: 10){
                        Image(systemName: "crown.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                            .tint(.gray)
                    }
                }).sheet(isPresented: $isPresentingGameCenter2, onDismiss: {}) {
                    GameCenterLeaderboardsViewControllerWrapper()
                }
                
                Button(action: {
                    
                }, label: {
                    VStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                            .tint(.gray)
                        
                    }
                })
            }
            .padding(20)
            
        }
        
    }
}


#Preview {
    TabBar()
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

struct GameCenterLeaderboardsViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = GKGameCenterViewController(state: .leaderboards)
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
