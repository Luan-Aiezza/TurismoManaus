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

struct GlassRectangle: View {
    var body: some View {
        ZStack {
            // Gradiente para simular o efeito de vidro fosco
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .frame(width: 350, height: 100) // Ajuste o tamanho conforme necessário
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            
        }
    }
}
struct Filtros {
    var categoria: Categorias?
    var preco: Precos?
}


struct Home: View {
    @State var selectedCategoria: Categorias
    @State var selectedHorario: Horarios
    @State var selectedDistancia: Distancias
    @State var selectedPreco: Precos
    
    
    @State var isShowingFilterView = false
    @State private var scene: SCNScene = SCNScene(named: "art.scnassets/GameScene.scn")!
    @State private var selectedTab: Int = 0
    
    //    @State private var filtros = FilterView(selectedCategoria: .todos, selectedPreco: .todos)
    
    @State private var pontoSelecionado: PontoTuristico?
    @State private var isShowingModal = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack{
                    Image("Background")
                        .blur(radius: 80)
                    VStack (spacing: 50){
                        
                        
                        Text("Turistando")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                        // Botão para selecionar aleatoriamente um ponto turístico
                        Button("Selecionar Ponto Turístico") {
                            pontoSelecionado = selecionarPontoTuristicoAleatorio()
                            isShowingModal = true
                        }
                        // Exibir o ponto turístico selecionado
                        .sheet(isPresented: $isShowingModal) {
                            if let ponto = pontoSelecionado {
                                Text(ponto.name)
                                Text(ponto.desc)
                                Text(ponto.id.uuidString)
                                Button("Selecionar Ponto Turístico") {
                                    pontoSelecionado = selecionarPontoTuristicoAleatorio()
                                }
                            } else {
                                Text("Nenhum filtro selecionado")
                            }
                        }
//                        if let ponto = pontoSelecionado {
//                            Text(ponto.name)
//                            Text(ponto.desc)
//                            Text(ponto.id.uuidString)
//                            Button("Selecionar Ponto Turístico") {
//                                pontoSelecionado = selecionarPontoTuristicoAleatorio()
//                            }
//                        } else {
//                        Text("Nenhum ponto turístico selecionado")
//                        }
                        
                        VStack{
                            Button(action: {
                                isShowingFilterView.toggle()
                            }, label: {
                                Image("btn_adjust")
                                    .imageScale(.large)
                                    .foregroundStyle(.tint)
                            })
                            TabBar()
                            
                        }
                        
                    }
                    .sheet(isPresented: $isShowingFilterView, content: {
                        FilterView(selectedCategoria: $selectedCategoria, selectedHorario: $selectedHorario, selectedDistancia: $selectedDistancia, selectedPreco: $selectedPreco)
                            .presentationDetents([.height(UIScreen.main.bounds.height/1.75)]) //Define o tamanho da aba de filtos
                    })
                    
                }
                
            }.onAppear {
                authenticateUser()
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
                
                // You can perform additional actions here
            }
        }
    }
    
    func selecionarPontoTuristicoAleatorio() -> PontoTuristico? {
        
        
        let pontosFiltrados = PontosTuristicos.filter { ponto in
            var corresponde = true
            
            if ponto.categoria != selectedCategoria {
                corresponde = false
            }
            
            if ponto.preco != selectedPreco {
                corresponde = false
            }
            
            
            return corresponde
        }
        
        return pontosFiltrados.randomElement()
    }
    
}




#Preview {
    Home(selectedCategoria: Categorias.todos, selectedHorario: Horarios.todos, selectedDistancia: Distancias.todos, selectedPreco: Precos.todos)
}
