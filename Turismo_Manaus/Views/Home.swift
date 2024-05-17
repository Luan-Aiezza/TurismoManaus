//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI
import SceneKit
import GameKit

struct GlassRectangle : View {
    
    var body: some View {
            // Gradiente para simular o efeito de vidro fosco
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .frame(width: 350, height: 100) // Ajuste o tamanho conforme necessário
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
    }
}

struct Home : View {
    @State var isShowingFilterView = false
    @State private var scene: SCNScene = SCNScene(named: "art.scnassets/GameScene.scn")!
    
    @State private var selectedTab: Tabs = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color.black
                Image("Background")
                    .blur(radius: 90)
                
                VStack{
                    Text("Olá Samuel!")
                        .font(.title)
                        .foregroundStyle(.white)
                    Spacer()
                }
                VStack {
                    Text("")
                    
                    Spacer()
                    Image("Card")
                    Spacer()
                    VStack(spacing: 25) {
                        Button(action: {
                            isShowingFilterView.toggle()
                        }, label: {
                            Image("btn_adjust")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        })

                    }
                }.padding().padding()
                
            }
        }.ignoresSafeArea()
    }
}

struct UI: View {
    
    @State var isShowingFilterView = false
    @State private var scene: SCNScene = SCNScene(named: "art.scnassets/GameScene.scn")!
    
    @State private var selectedTab: Tabs = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack{
            Color.black

            VStack{
                TabView (selection: $selectedTab) {
                    Home()
                        .tag(Tabs.home)
                    
                    VStack{
                        Text("achievements")
                    }
                        .tag(Tabs.achievements)
                    
                    Text("ranking")
                        .tag(Tabs.ranking)
                    
                    Text("me")
                        .tag(Tabs.me)
                }
                CustomTabBar(selectTab: $selectedTab)
            }
            
            
        }
        .onAppear {
            authenticateUser()
        }
        .ignoresSafeArea()
        
    }
//        GeometryReader { geometry in
//            ZStack{
//                Image("Background")
//                    .blur(radius: 160)
//                VStack (spacing: 160){
//                    Text("")
//                    
//                    SceneKitView(scene: scene)
//                        .frame(width: 150, height: 150)
//                    
//                    VStack{
//                        Button(action: {
//                            isShowingFilterView.toggle()
//                        }, label: {
//                            Image("btn_adjust")
//                                .imageScale(.large)
//                                .foregroundStyle(.tint)
//                        })
//                        .padding()
//                        .padding()
//                        
//                        
//                        CustomTabBar(selectTab: $selectedTab)
                        
//                    }
//                    
//                }
//                .sheet(isPresented: $isShowingFilterView, content: {
//                    FilterView()
//                        .presentationDetents([.height(UIScreen.main.bounds.height/1.75)]) //Define o tamanho da aba de filtos
//                })
//                
//            }
//            .navigationTitle("Turistando")
//
//            
//        }
//        .onAppear {
//            authenticateUser()
//        }
    
    
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
                
                // You can perform additional actions here
            }
        }
    }
    
}

struct SceneKitView: UIViewRepresentable {
    //    let sceneName: String
    let scene: SCNScene
    
    func makeUIView(context: Context) -> SCNView {
        // Cria uma cena do SceneKit
        //        let scene = SCNScene(named: sceneName + ".scn")!
        //        let scene = SCNScene(named: sceneName + ".scn")!
        
        // Cria uma SCNView para exibir a cena
        let scnView = SCNView()
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.backgroundColor = .clear
        scene.background.contents = UIColor.clear
        // Configura a cor do material do objeto
        //        let color = UIColor.red
        //        scene.rootNode.childNode(withName: "dice", recursively: true)?.geometry?.firstMaterial?.diffuse.contents = color
        
        return scnView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Atualiza a cena, se necessário
    }
}


#Preview {
    UI()
}

