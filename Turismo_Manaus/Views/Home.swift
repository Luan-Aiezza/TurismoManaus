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

class LocationViewModel: NSObject, ObservableObject {
    private var locationManager: CLLocationManager?
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0

    @Published var log: String = ""
    
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        super.init()
        self.locationManager = locationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            log = "Location authorization not determined"
        case .restricted:
            log = "Location authorization restricted"
        case .denied:
            log = "Location authorization denied"
        case .authorizedAlways:
            manager.requestLocation()
            log = "Location authorization always granted"
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            log = "Location authorization when in use granted"
        @unknown default:
            log = "Unknown authorization status"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { location in
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }
}

struct GlassRectangle : View {
    
    var body: some View {
        // Gradiente para simular o efeito de vidro fosco
        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            .frame(width: 350, height: 100) // Ajuste o tamanho conforme necessário
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
    }
}

struct Home : View {
    @State var selectedCategoria: Categorias
    @State var selectedHorario: Horarios
    @State var selectedDistancia: Distancias
    @State var selectedPreco: Precos
    
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
                
//                Carrossel()
//                Button(action: {
//                    pontoSelecionado = selecionarPontoTuristicoAleatorio()
//                    isShowingModal.toggle()
////sadawd
//                }, label: {
//                    Image("Card")
//                })
//                .sheet(isPresented: $isShowingModal) {
//                    if let ponto = pontoSelecionado {
//                        Text(ponto.name)
//                        Text(ponto.desc)
//                        Text(ponto.id.uuidString)
//                        Button("Selecionar Ponto Turístico") {
//                            pontoSelecionado = selecionarPontoTuristicoAleatorio()
//                        }
//                    } else {
//                        Text("Nenhum filtro selecionado")
//                    }
//                }

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
                
                    
                
                
            }
            .padding()
            
            Carrossel()
            
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
                // You can perform additional actions here
            }
        }
    }
    
}

#Preview {
    UI()
    
}
