//
//  HomeWithChallenge.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 23/05/24.
//

import SwiftUI
import GameKit
import Foundation
import CoreLocation
import CoreData

struct HomeWithChallenge : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default) private var desafios: FetchedResults<Desafios>
    
    @StateObject private var vm: HomeWithChallengeViewModel

    init(viewContext: NSManagedObjectContext) {
        _vm = StateObject(wrappedValue: HomeWithChallengeViewModel(viewContext: viewContext))
    }
    
    var body: some View {
        Group{
            if vm.isDetailViewShown {
                ChallengeDescription(isDetailViewShown: $vm.isDetailViewShown, locationViewModel: vm.locationViewModel)
                    .onAppear {
                        GKAccessPoint.shared.isActive = false
                    }
            } else {
                ZStack {
                    
                    Color.backgroundColor
                        .ignoresSafeArea()
                    
                    VStack{
                        Spacer()
                        if desafios.contains(where: { $0.state == "inProgress" && $0.user_id == vm.player.gamePlayerID  }) {
                            Button(action: {
                                vm.isDetailViewShown.toggle()
                            }, label: {
                                ChallengeCard()
                            })
                        }
                    }
                    .padding()
                    .padding(.horizontal)
                    
                    VStack{
                        Spacer()
                        Text(" ")
                        VStack (spacing: 32){
                            VStack{
                                Text("Olá, \(vm.player.displayName)!")
                                    .font(.title)
                                    .bold()
                                Text("Boa sorte com o desafio!")
                                    .font(.title3)
                                    .fontWeight(.thin)
                                
                            }
                            
                            VStack(spacing: 32) {
                                Carrossel(currentIndex: $vm.currentIndex)
                                
                                HStack {
                                    // Iniciar Random
                                    Button(action: {
                                        Task{
                                            vm.locationViewModel.pontoSelecionado = vm.selectRandomTuristicPoint()
                                            for (index, element) in PontosTuristicos.enumerated(){
                                                if vm.locationViewModel.pontoSelecionado?.name == element.name{
                                                    withAnimation(Animation.smooth) {
                                                        vm.currentIndex = index
                                                        Task {
                                                            try await Task.sleep(nanoseconds: 1_000_000_000) // Wait for 2 seconds
                                                            vm.isShowingModal.toggle()
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
                                        vm.isShowingFilterView.toggle()
                                        vm.calculateDistances()
                                    }, label: {
                                        
                                        Image(systemName: "slider.horizontal.3")
                                            .resizable()
                                            .frame(width: 21.662, height: 18.056)
                                    })
                                    .padding()
                                    .sheet(isPresented: $vm.isShowingFilterView) {
                                        FilterView(selectedCategoria: $vm.selectedCategoria, selectedHorario: $vm.selectedHorario, selectedDistancia: $vm.selectedDistancia, selectedPreco: $vm.selectedPreco, isShowingFilterView: $vm.isShowingFilterView, locationViewModel: vm.locationViewModel)
                                        
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
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .sheet(isPresented: $vm.isShowingModal) {
                            if let point = vm.locationViewModel.pontoSelecionado {
                                LauchChallengeModal(point: point, desafios: desafios)
                            } else {
                                Text("Nenhum filtro selecionado")
                            }
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 80, height: 80)
                            .opacity(0)
                        Spacer()
                        
                        
                    }
                    .padding()
                    .padding()
                    
                }
                .environmentObject(vm)
                .onAppear {
                    GKAccessPoint.shared.isActive = true
                }
                
            }
        }

           
    }
    
}
