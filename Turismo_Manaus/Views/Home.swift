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
        GeometryReader { geometry in
            NavigationStack {
                ZStack{
                    Image("background_1")
                        .imageScale(.large)
                        .foregroundStyle(.brown)
                    //VStack define a ordem dos itens na vertical
                    VStack (spacing: 200){//spacing é um parametro de espacamento geral entre os itens
                        //FILTROS
                        Button(action: {
                            isShowingFilterView.toggle()
                        }, label: {
                            Image("btn_adjust")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        })
                                                
                        SceneKitView(scene: scene)
                            .frame(width: 200, height: 200)
                        
                        
                    }
                    .sheet(isPresented: $isShowingFilterView, content: {
                        FilterView()
                        })
                    
                }
                .padding()
                
            }
        }
        
        TabView(selection: $selectedTab) {
            Home
                .tabItem {
                    Label("Dados", systemImage: "dice.fill")
                }
                .tag(0)

            Badges()
                .tabItem {
                    Label("Badges", systemImage: "rosette")
                }
                .tag(1)

            Ranking()
                .tabItem {
                    Label("Ranking", systemImage: "crown")
                }
                .tag(2)

            Me()
                .tabItem {
                    Label("Me", systemImage: "person.fill")
                }
                .tag(3)
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
