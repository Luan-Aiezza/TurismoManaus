
//
//  OnBoardingViewModel.swift
//  Simbora Manaus
//
//  Created by Italo Guilherme Monte on 11/08/25.
//

import SwiftUI
import GameKit
import CoreData
import CoreLocation

@MainActor
class HomeWithChallengeViewModel: ObservableObject {
    
    @ObservedObject var locationViewModel: LocationViewModel = .init()

    @Published var viewContext: NSManagedObjectContext

    @Published var selectedCategoria = Categories.todos
    @Published var selectedHorario = Hours.todos
    @Published var selectedDistancia = Distances.todos
    @Published var selectedPreco = Prices.todos
    @Published var player = GKLocalPlayer.local
    @Published var isShowingFilterView = false
    @Published var isShowingModal = false
    @Published var selectedTab: Tabs = .home
    @Published var currentIndex = 10
    @Published var isDetailViewShown = false
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func selectRandomTuristicPoint() -> PontoTuristico? {
        
        let pontosFiltrados = PontosTuristicos.filter { ponto in
            var corresponde = true
            
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
    
    
    func addChallenge( pontoId: String ) {
        let player = GKLocalPlayer.local
        let newItem = Desafios(context: viewContext)
        newItem.id = UUID()
        newItem.data_lancado = Date()
        newItem.data_termino = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        newItem.ponto_id = pontoId
        newItem.user_id = player.gamePlayerID
        newItem.state = "inProgress"
        do {
            try viewContext.save()
        } catch {
        }
        
    }
    
    func calculateDistances() {
        for i in 0..<PontosTuristicos.count {
            
            let location1 = CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
            let location2 = CLLocation(latitude: Double(PontosTuristicos[i].latitude) ?? 0.0, longitude: Double(PontosTuristicos[i].longitude) ?? 0.0)
            
            let distanceinMeters = (location1.distance(from: location2))
            let distanceInKilometers = distanceinMeters/1000
            
            if distanceInKilometers <= 3.0 {
                PontosTuristicos[i].distance = Distances.tres
                
            } else if distanceInKilometers > 3.0 && distanceInKilometers <= 5.0 {
                
                PontosTuristicos[i].distance = Distances.cinco
                
            } else if distanceInKilometers > 5.0 && distanceInKilometers <= 10.0 {
                
                PontosTuristicos[i].distance = Distances.dez
            }
            
        }
    }
    
}
