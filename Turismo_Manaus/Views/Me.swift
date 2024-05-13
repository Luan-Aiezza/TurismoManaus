//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI

struct Me: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        //ZStack define a ordem dos itens na layer
        
        TabView(selection: $selectedTab) {
            Text("home")
                .tabItem {
                    Label("Dados", systemImage: "dice.fill")
                }
                .tag(0)

            Text("badges")
                .tabItem {
                    Label("Badges", systemImage: "rosette")
                }
                .tag(1)

            Text("ranking")
                .tabItem {
                    Label("Ranking", systemImage: "crown")
                }
                .tag(2)

            Text("me")
                .tabItem {
                    Label("Me", systemImage: "person.fill")
                }
                .tag(3)
        }
    }
}

#Preview {
    Me()
}
