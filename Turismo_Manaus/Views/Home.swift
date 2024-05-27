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
import Foundation



class HomeViewModel {
    
    init(pontoSelecionado: PontoTuristico? = nil) {
    }
}

struct Home : View {
    @State var selectedCategoria = Categorias.todos
    @State var selectedHorario = Horarios.todos
    @State var selectedDistancia = Distancias.todos
    @State var selectedPreco = Precos.todos
    
    @ObservedObject var locationViewModel: LocationViewModel
    
    @State var player = GKLocalPlayer.local
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var isShowingFilterView = false
    @State var isShowingModal = false
    @State private var selectedTab: Tabs = .home
    @State var currentIndex = 10
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor
            
            VStack{
                Spacer()
                VStack{
                    Text("Oi, \(player.displayName)!")
                        .font(.title)
                        .bold()
                    Text("Para onde vamos hoje?")
                        .font(.title3)
                        .fontWeight(.thin)
                }
                Spacer()
                
                Carrossel(currentIndex: $currentIndex)
                
                
                HStack {
                    
                    // Iniciar Random
                    Button(action: {
                        Task{
                            //                            pontoSelecionado = selecionarPontoTuristicoAleatorio()
                            locationViewModel.pontoSelecionado = selecionarPontoTuristicoAleatorio()
                            for (index, element) in PontosTuristicos.enumerated(){
                                if locationViewModel.pontoSelecionado?.name == element.name{
                                    withAnimation(Animation.smooth) {
                                        currentIndex = index
                                        Task {
                                            try await Task.sleep(nanoseconds: 1_000_000_000) // Wait for 2 seconds
                                            isShowingModal.toggle()
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                        
                    }, label: {
                        ZStack {
                            Color.bgGlass1
                                .cornerRadius(100.0)
                            Text("Sortear")
                                .font(.headline)
                                .foregroundColor(.accentColorYellow)
                                .padding(.horizontal, 16.0)
                                .padding(.vertical, 12.0)
                        }
                        .frame(width: 96, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100.0)
                                .stroke(Color.bgGlass1, lineWidth: 2)
                        )
                        
                    })
                    
                    
                    // Filtros
                    Button(action: {
                        isShowingFilterView.toggle()
                        calculaDistancias()
                    }, label: {
                        
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .frame(width: 21.662, height: 18.056)
                    }).padding()
                        .sheet(isPresented: $isShowingFilterView) {
                            FilterView(selectedCategoria: $selectedCategoria, selectedHorario: $selectedHorario, selectedDistancia: $selectedDistancia, selectedPreco: $selectedPreco, locationViewModel: locationViewModel)
                                .presentationDetents([.large])
                                .onAppear {
                                    GKAccessPoint.shared.isActive = false
                                }
                                .onDisappear {
                                    GKAccessPoint.shared.isActive = true
                                }                        }
                    
                }
                .padding()
                Spacer()
                Spacer()
                
            }
            
            .padding()
            .foregroundStyle(.white)
            .sheet(isPresented: $isShowingModal) {
                
                if let ponto = locationViewModel.pontoSelecionado {
                    VStack (spacing: 20) {
                        Text("Desafio lançado!")
                            .presentationDetents([.medium])
                            .font(.title)
                            .foregroundStyle(.black)
                        Text("Visite o(a) \( Text(ponto.name).bold())  pela primeira vez no prazo de 1 semana.")
                        Image(transformString(ponto.name))
                            .resizable()
                            .frame(width: 150, height: 171)
                            .cornerRadius(15.0)
                            .scaledToFill()
                        
                        HStack{
                            Text(String(describing: ponto.categoria))
                            Text(String(describing: ponto.preco))
                            Text(String(describing: ponto.status))
                        }
                    }.padding()
                    
                    HStack{
                        Button("Recusar") {
                            isShowingModal = false
                        }
                        
                        Button("Aceitar") {
                            addDesafio(pontoId: transformString(ponto.name))
                            isShowingModal = false
                        }
                    }
                    
                } else {
                    Text("Nenhum filtro selecionado")
                }
                
            }
            .padding()
            
        }
    }
    
    func horarioInnerSelectedHorarios (horario: Horarios, setHorarios: [Horarios]) -> Bool {
        for horarioSet in setHorarios {
            if horario == horarioSet{
                return true
            }
        }
        return false
    }
    
    func selecionarPontoTuristicoAleatorio() -> PontoTuristico? {
        
        
        let pontosFiltrados = PontosTuristicos.filter { ponto in
            var corresponde = true
            
            if selectedHorario != Horarios.todos{
                if !horarioInnerSelectedHorarios(horario: selectedHorario, setHorarios: ponto.horarios) {
                    corresponde = false
                }
            }
            
            if selectedCategoria != Categorias.todos{
                if ponto.categoria != selectedCategoria {
                    corresponde = false
                }
            }
            
            if selectedPreco != Precos.todos {
                if ponto.preco != selectedPreco {
                    corresponde = false
                }
            }
            
            if selectedDistancia != Distancias.todos {
                if ponto.distancia != selectedDistancia {
                    corresponde = false
                }
            }
            
            return corresponde
        }
        
        return pontosFiltrados.randomElement()
    }
    
    private func addDesafio( pontoId: String ) {
        let player = GKLocalPlayer.local
        let newItem = Desafios(context: viewContext)
        newItem.id = UUID()
        newItem.data_lancado = Date()
        newItem.data_termino = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        newItem.ponto_id = pontoId
        newItem.user_id = player.gamePlayerID
        newItem.state = "inProgress"
        print(newItem)
        do {
            try viewContext.save()
            print(newItem)
        } catch {
        }
        
    }
    
    func calculaDistancias() {
        print(".....")
        for i in 0..<PontosTuristicos.count {
            let transformedString = transformString(PontosTuristicos[i].name)
            print(transformedString)
            let location1 = CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
            let location2 = CLLocation(latitude: Double(PontosTuristicos[i].latitude) ?? 0.0, longitude: Double(PontosTuristicos[i].longitude) ?? 0.0)
            let distanceinMeters = (location1.distance(from: location2))
            let distanceInKilometers = distanceinMeters/1000
            print(PontosTuristicos[i].name)
            print(distanceInKilometers)
            if distanceInKilometers <= 3.0 {                PontosTuristicos[i].distancia = Distancias.tres
            } else if distanceInKilometers > 3.0 && distanceInKilometers <= 5.0 {
                PontosTuristicos[i].distancia = Distancias.cinco
            } else if distanceInKilometers > 5.0 && distanceInKilometers <= 10.0 {
                
                PontosTuristicos[i].distancia = Distancias.dez
            }
            
        }
    }
    
}

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
                            
                            if desafios.contains(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID }) {
                                VStack{
                                    HomeWithChallenge()
                                }
                            } else {
                                VStack{
                                    Home(locationViewModel: locationViewModel, player: viewModel.player)
                                }
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
    
    
    
    
    private func addItem() {
        let player = GKLocalPlayer.local
        let newItem = Pontos_Visitados(context: viewContext)
        newItem.id = UUID()
        newItem.quant_idas = 3
        newItem.user_id = player.teamPlayerID
        print(newItem)
        print(player.teamPlayerID)
        do {
            try viewContext.save()
            print(newItem)
            unlockAchievement()
        } catch {
        }
        
    }
    private func unlockAchievement() {
        let achievement = GKAchievement(identifier: "cigs_1")
        achievement.percentComplete = 100
        achievement.showsCompletionBanner = true
        GKAchievement.report([achievement]) { error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("done!")
        }
    }
    
    private func deleteAllItems() {
        withAnimation {
            for item in desafios {
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

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Image(.appIcon29X29)
                    .resizable()
                    .frame(width: 160, height: 160)
            }
        }
        
    }
}



#Preview {
    UI()
    
}

extension Color {
    static let backgroundColor = Color(UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1))
}

struct CustomModalView: View {
    var body: some View {
        VStack {
            Text("Conteúdo do Modal")
                .font(.title)
                .padding()
            Spacer()
            // Adiciona um espaço flexível para empurrar o conteúdo para cima
            
            // Personalize a altura ajustando o frame do conteúdo
            Text("Este é um modal que ocupa apenas metade da tela.")
                .padding()
                .frame(height: UIScreen.main.bounds.height / 2)
                .background(Color.blue)
            
            Spacer() // Adiciona um espaço flexível para empurrar o conteúdo para cima
        }
    }
}
