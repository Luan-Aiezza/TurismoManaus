//
//  HomeWithChallenge.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 23/05/24.
//

import SwiftUI
import SceneKit
import GameKit
import CoreLocation
import Foundation

struct HomeWithChallenge : View {
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
        if isDetailViewShown {
            ChallengeDescription(isDetailViewShown: $isDetailViewShown, locationViewModel: locationViewModel)
                .onAppear {
                    GKAccessPoint.shared.isActive = false
                }
        } else {
            ZStack {
                
                Color.backgroundColor
                    .ignoresSafeArea()
                VStack{
                    VStack{
                        Text("Olá, \(player.displayName)!")
                            .font(.title)
                        Text("Para onde vamos hoje?")
                            .font(.title3)
                    }
                    Spacer()

                    VStack {
                        
                        Carrossel(currentIndex: $currentIndex)
                        
                        HStack {
                            
                            
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
                                    FilterView(selectedCategoria: $selectedCategoria, selectedHorario: $selectedHorario, selectedDistancia: $selectedDistancia, selectedPreco: $selectedPreco,
                                               isShowingFilterView: $isShowingFilterView, locationViewModel: locationViewModel)
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
                    }
                    
                    Spacer()
                    
                    if desafios.contains(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID }) {
                        Button(action: {
                            isDetailViewShown.toggle()
                        }, label: {
                            ChallengeCard()
                        })
                    }
                    
                    
                    
                }
                .padding()
                .foregroundStyle(.white)
                .sheet(isPresented: $isShowingModal) {
                    
                    if let ponto = locationViewModel.pontoSelecionado {
                        Text("Desafio lançado!")
                            .font(.title)
                            .foregroundStyle(.black)
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
                                addDesafio(pontoId: transformString(ponto.name))
                                isShowingModal = false
                            }
                        }
                        
                    } else {
                        Text("Nenhum filtro selecionado")
                    }
                    
                    Spacer()
                    
                }
                .padding(16.0)
            }
            .onAppear {
                GKAccessPoint.shared.isActive = true
            }
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
    
    func selecionarPontoTuristicoAleatorio() -> PontoTuristico? {
        
        
        let pontosFiltrados = PontosTuristicos.filter { ponto in
            var corresponde = true
            
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
        do {
            try viewContext.save()
            print(newItem)
        } catch {
        }
        
    }
    
}
