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
    @State private var isDetailViewShown = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default) private var desafios: FetchedResults<Desafios>
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor
            
            VStack{
                VStack (spacing: 16){
                    VStack{
                        Text("Oi, \(player.displayName)!")
                            .font(.title)
                            .bold()
                        Text("Para onde vamos hoje?")
                            .font(.title3)
                            .fontWeight(.thin)
                    }
                    
                    VStack(spacing: 16){
                        
                        Carrossel(currentIndex: $currentIndex)
                        
                        HStack {
                            
                            // Iniciar Random
                            Button(action: {
                                Task{
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
                            })
                            .padding()
                            .sheet(isPresented: $isShowingFilterView) {
                                FilterView(selectedCategoria: $selectedCategoria, selectedHorario: $selectedHorario, selectedDistancia: $selectedDistancia, selectedPreco: $selectedPreco, isShowingFilterView: $isShowingFilterView, locationViewModel: locationViewModel)
                                
                                    .presentationDetents([.large])
                                    .presentationBackground(content: {
                                        Color(.bgGlass2)
                                            .blur(radius: 25)
                                    })
                                    .onAppear {
                                        GKAccessPoint.shared.isActive = false
                                    }
                                    .onDisappear {
                                        GKAccessPoint.shared.isActive = true
                                    }
                            }
                            
                        }
                        .padding()
                    }
                    
                }
                .padding()
                .foregroundStyle(.white)
                .sheet(isPresented: $isShowingModal) {
                    if let ponto = locationViewModel.pontoSelecionado {
                        ZStack {
                            Color.black
                                .opacity(0.8)
                            //                        LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom)
                            
                            //                            .ignoresSafeArea()
                            //                            .blur(radius: 50.0)
                            //                            .border(Color.bgGlass1, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                            //                            .overlay(
                            //                                Rectangle()
                            //                                    .frame(height: 1)
                            //                                    .foregroundColor(.clear), alignment: .bottom
                            //                            )
                            VStack(spacing: 12) {
                                Text("Desafio lançado!")
                                    .font(.title)
                                Text("Visite o(a) \( Text(ponto.name).bold())  pela primeira vez no prazo de 1 semana.")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                Image(transformString(ponto.name))
                                    .resizable()
                                    .scaledToFit()
                                    .scaledToFill()
                                    .frame(width: 358, height: 176)
                                    .cornerRadius(15.0)
                                    .padding(.vertical, 24.0)
                                
                                HStack{
                                    // Recusar
                                    Button(action: {
                                        isShowingModal = false
                                    }
                                           , label: {
                                        ZStack {
                                            
                                            HStack {
                                                Text("Recusar")
                                                    .foregroundStyle(.white)
                                                    .font(.headline)
                                            }
                                            .padding(.vertical,12.0)
                                        }
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                        .background(Color.bgGlass1)
                                        .cornerRadius(100.0)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 100.0)
                                                .stroke(Color.bgGlass1, lineWidth: 2)
                                        )
                                    })
                                    Spacer()
                                    // Aceitar
                                    Button(action: {
                                        addDesafio(pontoId: transformString(ponto.name))
                                        isShowingModal = false
                                    }
                                           , label: {
                                        ZStack {
                                            
                                            HStack {
                                                Text("Aceitar")
                                                    .foregroundStyle(.accentColorYellow)
                                                    .font(.headline)
                                            }
                                            .padding(.vertical,12.0)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .background(Color.bgGlass1)
                                        .cornerRadius(100.0)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 100.0)
                                                .stroke(Color.bgGlass1, lineWidth: 2)
                                        )
                                        
                                    })
                                }
                                
                                Text("")
                                Text("")
                                
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.vertical,24.0)
                            .foregroundStyle(.white)
                            
                            
                        }.presentationDetents([.fraction(0.6)])
                            .ignoresSafeArea()
                            .presentationBackground(content: {
                                Color(.bgGlass2)
                                    .blur(radius: 25)
                            })
                        
                        
                    } else {
                        Text("Nenhum filtro selecionado")
                    }
                    
                }
                
                
                
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: 80, height: 80)
                .opacity(0)
                
                
            }
            .padding()
            .padding()
        }
        .onAppear {
            GKAccessPoint.shared.isActive = true
        }
    }
    
    func horarioInnerSelectedHorarios (horario: Horarios, setHorarios: [Horarios]) -> Bool {
        for horarioSet in setHorarios {
            if horario == horarioSet{
                return true
            }
        }
        if setHorarios.contains(Horarios.todos) {return true}
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
