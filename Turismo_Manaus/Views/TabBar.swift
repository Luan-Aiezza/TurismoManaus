//
//  TabBar.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 14/05/24.
//

import SwiftUI
import GameKit

enum Tabs: String, CaseIterable {
    case home = "rectangle.on.rectangle"
    case achievements = "star"
    case ranking = "crown"
    case me = "person"
}

struct CustomTabBar: View {
    
    @Binding var selectTab: Tabs
    var fill: String {
        selectTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack{
                ForEach(Tabs.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectTab == tab ? fill : tab.rawValue)
                        .scaleEffect(selectTab == tab ? 1.15 : 1)
                        .foregroundStyle(Color.gray)
                        .font(.system(size: 34))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectTab = tab
                            }
                        }
                    Spacer()
                //
                }
            }
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
            } catch {
            }
        
    }
}

//struct TabBar: View {
//    @State private var isPresentingAchievements = false
//    @State private var isPresentingLeaderboard = false
//    @State private var isPresentingProfile = false
//    
//    @Binding var selectTab: Tabs
//
//    var body: some View {
//                        
//            VStack (alignment: .center, spacing: 40){
//                Button(action: {
//                    withAnimation(.easeIn(duration: 0.1)){
//                        selectTab = .home
//                    }
//                }, label: {
//                    VStack{
//                        let home = Image(systemName: "dice")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 34)
//                        if selectTab == .home {
//                            home
//                                .scaleEffect(1.15)
//                        } else {
//                            home
//                                .tint(.gray)
//                                .scaleEffect(1)
//                        }
//                        
//                    }
//                })
//                
//                Button(action: {
////                    isPresentingAchievements = true
//                    withAnimation(.easeIn(duration: 0.1)){
//                        selectTab = .achievements
//                    }
//                }, label: {
//                    VStack{
//                        let achievement =  Image(systemName: "rosette")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 24)
//                        
//                        if selectTab == .achievements {
//                            achievement
//                                .scaleEffect(1.15)
//
//                        } else {
//                            achievement
//                                .tint(.gray)
//                                .scaleEffect(1)
//
//                        }
//                    }
//                    
//                }).sheet(isPresented: $isPresentingAchievements, onDismiss: {}) {
//                    GameCenterAchievementsViewControllerWrapper()
//                }
//                
//                Button(action: {
//                    withAnimation(.easeIn(duration: 0.1)){
//                        selectTab = .crown
//                    }
////                    isPresentingLeaderboard = true
//                }, label: {
//                    VStack (alignment: .center, spacing: 10){
//                        
//                        let ranking = Image(systemName: "crown")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 44)
//                        
//                        if selectTab == .crown {
//                            ranking
//                                .scaleEffect(1.15)
//
//                        } else {
//                            ranking
//                                .tint(.gray)
//                                .scaleEffect(1.0)
//
//                        }
//                    }
//                }).sheet(isPresented: $isPresentingLeaderboard, onDismiss: {}) {
//                    GameCenterLeaderboardsViewControllerWrapper()
//                }
//                
//                Button(action: {
//                    withAnimation(.easeIn(duration: 0.1)){
//                        selectTab = .person
//                    }
////                    isPresentingProfile = true
//                }, label: {
//                    VStack{
//                        let person = Image(systemName: "person")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 34)
//                            
//                        
//                        if selectTab == .person {
//                            person
//                            .scaleEffect(1.15)
//                        } else {
//                            person
//                            .tint(.gray)
//                            .scaleEffect(1.0)
//
//                        }
//                    }
//                })
//                .sheet(isPresented: $isPresentingProfile, onDismiss: {}) {
//                    GameCenterProfileViewControllerWrapper()
//                }
//            }
//            .padding(20)
//            
//        }
//        
//    
//}


#Preview {
    CustomTabBar(selectTab: .constant(.home))
}

