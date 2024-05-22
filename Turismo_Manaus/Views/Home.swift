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
import CoreLocation
import CoreImage
import Foundation


struct GlassRectangle : View {
    
    var body: some View {
        // Gradiente para simular o efeito de vidro fosco
        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            .frame(width: 350, height: 100) // Ajuste o tamanho conforme necessário
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
    }
}

struct Home : View {
    @State var selectedCategoria = Categorias.todos
    @State var selectedHorario: Horarios
    @State var selectedDistancia = Distancias.todos
    @State var selectedPreco = Precos.todos
    
    @State private var pontoSelecionado: PontoTuristico?
    @State var isShowingFilterView = false

    @State var isShowingModal = false

    @State private var selectedTab: Tabs = .home
    
    var body: some View {
        ZStack {
            
            Color.black
            
            VStack{
                Text("Olá Samuel!")
                    .font(.title)
                    .foregroundStyle(.white)
                
                
                Spacer()
                
                Button(action: {
                    pontoSelecionado = selecionarPontoTuristicoAleatorio()
                    isShowingModal.toggle()
//sadawd
                }, label: {
                    Image("Card")
                })

                .sheet(isPresented: $isShowingModal) {
                    if let ponto = pontoSelecionado {
                        Text("Desafio lançado!")
                            .font(.title)
                        Text("Visite o(a) \(ponto.name) em até uma semana!")
                        Image("Card")
                        
                        HStack{
                            Text(String(describing: ponto.categoria))
                            Text(String(describing: ponto.preco))
                            Text(String(describing: ponto.status))
                        }
                        
                        HStack{
                            Button("Recusar") {
                                isShowingModal = false
                            }
                            
                            Button("Aceitar") {
                                isShowingModal = false
                            }
                        }
                        
                    } else {
                        Text("Nenhum filtro selecionado")
                    }
                    
                }
                Spacer()
                
                Button(action: {
                    isShowingFilterView.toggle()
                }, label: {
                    Image("btn_adjust")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }).padding()
                    .sheet(isPresented: $isShowingFilterView) {
                        FilterView(selectedCategoria: $selectedCategoria, selectedHorario: $selectedHorario, selectedDistancia: $selectedDistancia, selectedPreco: $selectedPreco)
                    }
                
                    
                
                
            }.padding()
            
        }
        
    }
    
    func selecionarPontoTuristicoAleatorio() -> PontoTuristico? {
        
        
        let pontosFiltrados = PontosTuristicos.filter { ponto in
            var corresponde = true
            
            if selectedCategoria == Categorias.todos{
                corresponde = true
            } else if ponto.categoria != selectedCategoria {
                corresponde = false
            }
            
            if selectedPreco == Precos.todos {
                corresponde = true
            } else if ponto.preco != selectedPreco {
                corresponde = false
            }
            
            if selectedDistancia == Distancias.todos {
                corresponde = true
            } else if ponto.distancia != selectedDistancia {
                corresponde = false
            }
            
            return corresponde
        }
        
        return pontosFiltrados.randomElement()
    }
    
}

struct UI: View{
    
    @State var isShowingFilterView = false
    @State private var scene: SCNScene = SCNScene(named: "art.scnassets/GameScene.scn")!
    @State private var selectedTab: Tabs = .home
    @ObservedObject private var locationViewModel = LocationViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack{
                TabView (selection: $selectedTab) {
                    Home(selectedCategoria: Categorias.todos, selectedHorario: Horarios.todos, selectedDistancia: Distancias.todos, selectedPreco: Precos.todos)
                        .tag(Tabs.home)
                        .background(Color.black)
                    
                    Achievements()
                        .tag(Tabs.achievements)
                    
                    Ranking()
                        .tag(Tabs.ranking)
                    
                    Me()
                        .tag(Tabs.me)
                }
                
                
                CustomTabBar(selectTab: $selectedTab)
            }
            
            
        }.onAppear {
            authenticateUser()
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
                GKAccessPoint.shared.location = .topLeading
                GKAccessPoint.shared.showHighlights = false
                GKAccessPoint.shared.isActive = true
                print(locationViewModel.latitude)
                print(locationViewModel.longitude)
                calculaDistancias()
                // You can perform additional actions here
            }
        }
    }
    
    func calculaDistancias() {
        
        for i in 0..<PontosTuristicos.count {
            let transformedString = transformString(PontosTuristicos[i].name)
            print(transformedString)
            let location1 = CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
            let location2 = CLLocation(latitude: Double(PontosTuristicos[i].latitude) ?? 0.0, longitude: Double(PontosTuristicos[i].longitude) ?? 0.0)
            let distanceinMeters = (location1.distance(from: location2))
            let distanceInKilometers = distanceinMeters/1000
            if distanceInKilometers <= 3.0 {

                PontosTuristicos[i].distancia = Distancias.tres
            } else if distanceInKilometers > 3.0 && distanceInKilometers <= 5.0 {
                PontosTuristicos[i].distancia = Distancias.cinco
            } else if distanceInKilometers > 5.0 && distanceInKilometers <= 10.0 {

                PontosTuristicos[i].distancia = Distancias.dez
            }

        }
    }
    
    func removeAccents(from string: String) -> String {
        return string.applyingTransform(.stripCombiningMarks, reverse: false) ?? string
    }
    
    func removeSymbols(from string: String) -> String {
        return string.replacingOccurrences(of: "'", with: "")
    }
    
    func removeSpaces(from string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    func removeTrates(from string: String) -> String {
        return string.replacingOccurrences(of: "-", with: "")
    }
    
    func convertToLowerCase(_ string: String) -> String {
        return string.lowercased()
    }
    
    func transformString(_ string: String) -> String {
        let stringWithoutAccents = removeAccents(from: string)
        let stringWithoutSpaces = removeSpaces(from: stringWithoutAccents)
        let stringWithoutSymbols = removeSymbols(from: stringWithoutSpaces)
        let stringWithoutTrates = removeTrates(from: stringWithoutSymbols)
        let lowercasedString = convertToLowerCase(stringWithoutTrates)
        return lowercasedString
    }
}

#Preview {
    UI()
    
}
