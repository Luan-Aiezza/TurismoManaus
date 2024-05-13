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

    
    var body: some View {
        //ZStack define a ordem dos itens na layer
        NavigationStack {
            ZStack{
                //FUNDO
                //CODIGO DE FUNDO
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
                    
                    
                    //ROLAGEM DE DADOS
                    SceneKitView(scene: scene)
                        .frame(width: 200, height: 200)
//                    scene.background.contents = UIColor.clear
                                        
                    
                    //ICONES
                    //HStack define a ordem dos itens na horizontal
                    HStack (spacing: 50){
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image("AppIcon29x29 1")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        })
        

                        NavigationLink(destination: Badges()) {
                            Image("AppIcon29x29 2")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                        
                        NavigationLink(destination: Ranking()) {
                            Image("AppIcon29x29 3")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                        
                        NavigationLink(destination: Me()) {
                            Image("AppIcon29x29")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                    
                    }
                }
                .sheet(isPresented: $isShowingFilterView, content: {
                    FilterView()
                })
                //POPUP NA TELA DO LOCAL SPAWMADO
                //CODIGO DO POPUP
                //-----------xxxxx----------
            }
            .padding()
            
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
