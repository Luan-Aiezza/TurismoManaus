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
    @State var locationViewModel = LocationViewModel()
    @State var player = GKLocalPlayer.local
    var vm = HomeViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @State var isShowingFilterView = false
    @State var isShowingModal = false
    @State private var selectedTab: Tabs = .home
    @State var currentIndex = 10
    @State private var hasTimeElapsed = false
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor
                .ignoresSafeArea()
            VStack{
                VStack{
                    Text("Olá\(player.displayName)!")
                        .font(.title)
                    Text("Para onde vamos hoje?")
                        .font(.title3)
                }
                Spacer()
                Spacer()
                VStack {
                    Carrossel(currentIndex: $currentIndex)
                    
                    
                    
                    HStack {
                        
                        
                        // Filtros
                        Button(action: {
                            isShowingFilterView.toggle()
                        }, label: {
                            
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 21.662, height: 18.056)
                        }).padding()
                            .sheet(isPresented: $isShowingFilterView) {
                                FilterView(selectedCategoria: $selectedCategoria, selectedHorario: $selectedHorario, selectedDistancia: $selectedDistancia, selectedPreco: $selectedPreco)
                            }
                    }
                }
                Spacer()
                
                Spacer()
                
                ChallengeCard()
                
                
            }
            .padding()
            .foregroundStyle(.white)
            .sheet(isPresented: $isShowingModal) {
                
                if let ponto = vm.pontoSelecionado {
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

#Preview {
    HomeWithChallenge()
    
}
