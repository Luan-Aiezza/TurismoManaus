//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI
import SceneKit

struct GlassRectangle: View {
    var body: some View {
        ZStack {
            // Gradiente para simular o efeito de vidro fosco
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .frame(width: 350, height: 100) // Ajuste o tamanho conforme necessário
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))

            
//            // Retângulo arredondado
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color.clear)
//                .frame(width: 200, height: 100) // Ajuste o tamanho conforme necessário
//                .overlay(
//                    Text("Seu texto aqui")
//                        .foregroundColor(.white) // Cor do texto
//                )
        }
    }
}

struct Home: View {
    
    @State var isShowingFilterView = false
    @State private var scene: SCNScene = SCNScene(named: "art.scnassets/GameScene.scn")!
    @State private var selectedTab: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack{
                    
                    
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
                        
                        TabBar()
//                        GlassRectangle()
                        
                    }
                    .sheet(isPresented: $isShowingFilterView, content: {
                        FilterView()
                    })
                    
                }
                
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
