//
//  UI.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 27/05/24.
//

import SwiftUI
import GameKit

struct UI: View{
    @StateObject private var viewModel = MyViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var locationViewModel = LocationViewModel()
    
    @State private var player = GKLocalPlayer.local
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pontos_Visitados.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Pontos_Visitados>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default)
    private var desafios: FetchedResults<Desafios>
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack{
            Color.backgroundColor
                .ignoresSafeArea()
            Group {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                        VStack{
                            HomeWithChallenge(locationViewModel: locationViewModel)                                
                        }
                }
            }
            .onAppear {
                viewModel.performTask()
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
                print(player.displayName)
                GKAccessPoint.shared.location = .topLeading
                GKAccessPoint.shared.showHighlights = false
                GKAccessPoint.shared.isActive = true
                print(locationViewModel.latitude)
                print(locationViewModel.longitude)
                deleteAllItems()
                
                // You can perform additional actions here
            }
        }
    }
    
    private func deleteAllItems() {
        withAnimation {
            for item in items {
                viewContext.delete(item)
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func viewItem() {
        for i in 0..<items.count {
            print("Idas \(items[i].quant_idas)")
            print("UserId \(items[i].user_id ?? "")")
        }
        
    }
}

#Preview {
    UI()
}
