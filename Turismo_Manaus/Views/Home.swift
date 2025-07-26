//
//  Home.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 11/06/24.
//

import Foundation
import SwiftUI
import GameKit
import CoreLocation

struct Home : View {
    @State var selectedCategoria = Categories.todos
    @State var selectedHorario = Hours.todos
    @State var selectedDistancia = Distances.todos
    @State var selectedPreco = Prices.todos
    
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
                HStack{
                    Spacer()
                    // Filtros
                    Button(action: {
                        isShowingFilterView.toggle()
                        calculaDistances()
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
                VStack (spacing: 40){
                    VStack{
                        Text("Oi, \(player.displayName)!")
                            .font(.title)
                            .bold()
                        Text("Para onde vamos hoje?")
                            .font(.title3)
                            .fontWeight(.thin)
                    }
                    
                    VStack(spacing: 60){
                        
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
                                    Text("Sortear")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.accentColorYellow)
                                        .padding(.horizontal, 26.0) //Antes 26
                                        .padding(.vertical, 18.0) //antes 18
                                }
                                .background(Color.bgGlass1)
                                .cornerRadius(100.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100.0)
                                        .stroke(Color.bgGlass1, lineWidth: 2)
                                )
                                
                            })
                            
                        }
                    }
                    
                }
                .padding()
                .foregroundStyle(.white)
                .sheet(isPresented: $isShowingModal) {
                    if let ponto = locationViewModel.pontoSelecionado {
                        ZStack {
                            Color.black
                                .opacity(0.8)
                        
                            VStack(spacing: 12) {
                                Text("Desafio lançado!")
                                    .font(.title)
                                Text("Visite o(a) \( Text(ponto.name).bold())  pela primeira vez no prazo de 1 semana.")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                Image(ponto.imageName)
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

            }
            .padding()
            .padding()
        }
        .onAppear {
            GKAccessPoint.shared.isActive = true
        }
    }
    
    func horarioInnerSelectedHours (horario: Hours, setHours: [Hours]) -> Bool {
        for horarioSet in setHours {
            if horario == horarioSet{
                return true
            }
        }
        if setHours.contains(Hours.todos) {return true}
        return false
    }
    
    func selecionarPontoTuristicoAleatorio() -> PontoTuristico? {
        
        
        let pontosFiltrados = PontosTuristicos.filter { ponto in
            var corresponde = true
            
            if selectedHorario != Hours.todos{
                if !horarioInnerSelectedHours(horario: selectedHorario, setHours: ponto.horarios) {
                    corresponde = false
                }
            }
            
            if selectedCategoria != Categories.todos{
                if ponto.categoria != selectedCategoria {
                    corresponde = false
                }
            }
            
            if selectedPreco != Prices.todos {
                if ponto.preco != selectedPreco {
                    corresponde = false
                }
            }
            
            if selectedDistancia != Distances.todos {
                if ponto.distance != selectedDistancia {
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
    
    func calculaDistances() {
        print(".....")
        for i in 0..<PontosTuristicos.count {

            let location1 = CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
            let location2 = CLLocation(latitude: Double(PontosTuristicos[i].latitude) ?? 0.0, longitude: Double(PontosTuristicos[i].longitude) ?? 0.0)
            let distanceinMeters = (location1.distance(from: location2))
            let distanceInKilometers = distanceinMeters/1000

            if distanceInKilometers <= 3.0 {                PontosTuristicos[i].distance = Distances.tres
            } else if distanceInKilometers > 3.0 && distanceInKilometers <= 5.0 {
                PontosTuristicos[i].distance = Distances.cinco
            } else if distanceInKilometers > 5.0 && distanceInKilometers <= 10.0 {
                
                PontosTuristicos[i].distance = Distances.dez
            }
            
        }
    }
    
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
