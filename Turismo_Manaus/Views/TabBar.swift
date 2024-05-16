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
    @State private var isPresentingAchievements = false
    @State private var isPresentingLeaderboard = false
    @State private var isPresentingProfile = false
    
    @Binding var selectTab: Tabs

    var body: some View {
            
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .frame(width: 358, height: 70) // Ajuste o tamanho conforme necessário
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack (alignment: .center, spacing: 40){
                Button(action: {
                    selectTab = .dice
                }, label: {
                    VStack{
                        var dice = Image(systemName: "dice.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                        if selectTab == .dice {
                            dice
                        } else {
                            dice
                                .tint(.gray)
                        }
                        
                    }
                })
                
                Button(action: {
                    isPresentingAchievements = true
                }, label: {
                    VStack{
                        var achievement =  Image(systemName: "rosette")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        
                        if selectTab == .achievement {
                            achievement
                        } else {
                            achievement
                                .tint(.gray)
                        }
                    }
                    
                }).sheet(isPresented: $isPresentingAchievements, onDismiss: {}) {
                    GameCenterAchievementsViewControllerWrapper()
                }
                
                Button(action: {
                    isPresentingLeaderboard = true
                }, label: {
                    VStack (alignment: .center, spacing: 10){
                        
                        var ranking = Image(systemName: "crown.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                        
                        if selectTab == .ranking {
                            ranking
                        } else {
                            ranking
                                .tint(.gray)
                        }
                    }
                }).sheet(isPresented: $isPresentingLeaderboard, onDismiss: {}) {
                    GameCenterLeaderboardsViewControllerWrapper()
                }
                
                Button(action: {
                    isPresentingProfile = true
                }, label: {
                    VStack{
                        var me = Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                            
                        
                        if selectTab == .me {
                            me
                        } else {
                            me
                                .tint(.gray)
                        }
                    }
                }).sheet(isPresented: $isPresentingProfile, onDismiss: {}) {
                    GameCenterProfileViewControllerWrapper()
                }
            }
            .padding(20)
            
        }
        
    }
}


#Preview {
    TabBar(selectTab: .constant(.dice))
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

struct GameCenterProfileViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = GKGameCenterViewController(state: .localPlayerProfile)
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
