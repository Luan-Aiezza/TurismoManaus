//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI
import SceneKit

struct Home: View {
    
    @State var isShowingFilterView = false
    @State private var scene: SCNScene = SCNScene(named: "art.scnassets/GameScene.scn")!
    @State private var selectedTab: Int = 0
    
    var body: some View {
        //ZStack define a ordem dos itens na layer
        TabView (selection: $selectedTab) {
            GeometryReader { geometry in
                NavigationStack {
                    ZStack{
                        Image("background_1")
                            .imageScale(.large)
                            .foregroundStyle(.brown)
            
                        VStack (spacing: 200){
                            Button(action: {
                                isShowingFilterView.toggle()
                            }, label: {
                                Image("btn_adjust")
                                    .imageScale(.large)
                                    .foregroundStyle(.tint)
                            })
                            
                            SceneKitView(scene: scene)
                                .frame(width: 200, height: 200)
                            
                            Text("")
                            
                        }
                        .sheet(isPresented: $isShowingFilterView, content: {
                            FilterView()
                        })
                        
                    }
                    .padding()
                    
                }
            }
            .tabItem {
                Label("Dados", systemImage: "dice.fill")
            }
            
            Badges()
                .tabItem {
                    Label("Badges", systemImage: "rosette")
                }
            
            Ranking()
                .tabItem {
                    Label("Badges", systemImage: "crown")
                }
            
            Me()
                .tabItem {
                    Label("Badges", systemImage: "person.fill")
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
    Home()
}
