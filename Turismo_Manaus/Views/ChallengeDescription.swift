//
//  ChallengeDescription.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 24/05/24.
//

import Foundation
import SwiftUI
import SceneKit
import GameKit
import CoreLocation

enum ActiveAlert: Identifiable {
    case alert1, alert2
    
    var id: Int {
        hashValue
    }
}

struct ChallengeDescription: View {
    @Binding var isDetailViewShown: Bool
    @State private var activeAlert: ActiveAlert?
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default) private var desafios: FetchedResults<Desafios>
    @State var player = GKLocalPlayer.local
    @State var preco = "$$"
    @Environment(\.openURL) var openURL
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var locationViewModel: LocationViewModel
    @State var distanceinMeters = 0.0
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pontos_Visitados.id, ascending: true)],
        animation: .default)
    private var pontosvisitados: FetchedResults<Pontos_Visitados>


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
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
                .onAppear {
                    calculaPreco()
                    calculaDistancia()
                }
            if desafios.contains(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID }) {
                VStack  {
                    HStack {
                        Button(action: {
                            isDetailViewShown.toggle()
                        }, label: {
                            ZStack {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(.white)
                                    
                                    Text("Voltar")
                                        .foregroundStyle(.white)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                            }
                            
                        })
                        Spacer()
                        Text("Desafio ativo")
                            .padding(.vertical, 8.0)
                            .foregroundStyle(.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, content: {
                        
                        Text("Visitar o(a) \( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.name) pela primeira vez")
                            .foregroundStyle(.white)
                            .padding(.vertical, 24.0)
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("\( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.name)")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("\( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.desc)")
                            .foregroundStyle(.white)
                            .font(.body)
                            .padding(.vertical, 16.0)
                        HStack {
                            ZStack {
                                Text("\( capitalizeFirstLetter( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.categoria.rawValue))")
                                    .foregroundStyle(.white)
                                    .padding(.horizontal,10.0)
                                    .padding(.vertical, 3.0)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 7.0)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            
                            ZStack {
                                Text("\(preco)")
                                    .foregroundStyle(.white)
                                    .padding(.horizontal,10.0)
                                    .padding(.vertical, 3.0)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 7.0)
                                    .stroke(Color.white, lineWidth: 1)
                                
                            )
                            .padding(.horizontal, 12.0)
                            ZStack {
                                Text("\(capitalizeFirstLetter( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.status))")
                                    .foregroundStyle(.white)
                                    .padding(.horizontal,10.0)
                                    .padding(.vertical, 3.0)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 7.0)
                                    .stroke(Color.white, lineWidth: 1)
                                
                            )
                        }
                        
                        Text("\(capitalizeFirstLetter( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.endereco))")
                            .foregroundStyle(.white)
                            .padding(.vertical,24.0)
                            .font(.body)
                    })
                    
                    HStack {
                        Button(action: {
                            if let url = URL(string: PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.maps) {
                                openURL(url)
                            }
                            
                        }, label: {
                            ZStack {
                                
                                HStack {
                                    Image(systemName: "location")
                                        .foregroundColor(.white)
                                    Text("Ver no mapa")
                                        .foregroundStyle(.white)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal,16.0)
                                .padding(.vertical,12.0)
                            }.background(Color.bgGlass1)
                                .cornerRadius(100.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100.0)
                                        .stroke(Color.bgGlass1, lineWidth: 2)
                                )
                        })
                        
                        Spacer()
                        Button(action: {
                            if let url = URL(string: PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.link) {
                                openURL(url)
                            }
                        }, label: {
                            ZStack {
                                
                                HStack {
                                    Image(systemName: "arrow.up.right.square")
                                        .foregroundColor(.white)
                                    Text("Saber mais")
                                        .foregroundStyle(.white)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal,16.0)
                                .padding(.vertical,12.0)
                            }.background(Color.bgGlass1)
                                .cornerRadius(100.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100.0)
                                        .stroke(Color.bgGlass1, lineWidth: 2)
                                )
                        })
                        
                    }
                    if distanceinMeters > 80.0 {
                        Button(action: {
                            activeAlert = .alert2
                        }, label: {
                            ZStack {
                                
                                HStack {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                    Text("Concluir")
                                        .foregroundStyle(.white)
                                        .font(.title3)
                                        .fontWeight(.semibold)
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
                            .padding(.vertical, 16.0)
                        })
                        
                        
                    } else {
                        Button(action: {
                            registraLocalVisitado()
                        }, label: {
                            ZStack {
                                
                                HStack {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                    Text("Concluir")
                                        .foregroundStyle(.white)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                .padding(.vertical,12.0)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.greenButton)
                            .cornerRadius(100.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100.0)
                                    .stroke(Color.greenButton, lineWidth: 2)
                            )
                            .padding(.vertical, 16.0)
                        })
                    }
                    
                    Button {
                        activeAlert = .alert1
                    } label: {
                        ZStack {
                            
                            HStack {
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                Text("Desistir")
                                    .foregroundStyle(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical,12.0)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.redGlass)
                        .cornerRadius(100.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100.0)
                                .stroke(Color.redGlass, lineWidth: 2)
                        )
                    }
                    
                    Spacer()
                }
                .alert(item: $activeAlert) { alert in
                            switch alert {
                            case .alert1:
                                return Alert(title: Text("Deseja mesmo desistir do desafio?"), message: Text("Visitar o \( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.name)"), primaryButton: Alert.Button.cancel(),
                                             secondaryButton: Alert.Button.destructive(Text("Desistir"), action: {
                                    
                                    isDetailViewShown = true
                                    
                                           registraDesafioFracassado()
                                           
                                       }))
                            case .alert2:
                                return Alert(
                                    title: Text("Você ainda não está no local"),
                                    message: Text("Se aproxime do local escolhido para concluir o desafio"),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                        }
                
                .padding(.horizontal, 16.0)
                .padding(.vertical,24.0)
            }
        }
    }
    
    private func calculaPreco () {
        if (PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.preco) == Precos.barato {
            preco = "$"
        } else if (PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.preco) == Precos.medio {
            preco = "$$"
        } else {
            preco = "$$$"
        }
    }
    
    private func calculaDistancia() {
        print(".....")
        let location1 = CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
        let location2 = CLLocation(latitude: Double(PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.latitude) ?? 0.0, longitude: Double(PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.longitude) ?? 0.0)
        print(location1)
        print(location2)
        distanceinMeters = (location1.distance(from: location2))
        print(distanceinMeters)
    }
    
    private func registraLocalVisitado() {
        let player = GKLocalPlayer.local
        
        
        
        if pontosvisitados.contains(where: { $0.ponto_name == PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.name && $0.user_id == player.gamePlayerID }) {
            pontosvisitados.first( where: { $0.ponto_name == PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.name && $0.user_id == player.gamePlayerID })!.quant_idas += 1
            var item = Pontos_Visitados(context: viewContext)
            item = pontosvisitados.first( where: { $0.ponto_name == PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.name && $0.user_id == player.gamePlayerID })!
            
            var desafio = Desafios(context: viewContext)
            desafio = desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!
            desafio.state = "Concluído"
            
            do {
                try viewContext.save()
                print(item)
                print(desafio)
                unlockAchievement(item: item)
                isDetailViewShown.toggle()
            } catch {
            }
            
        } else {
            let newItem = Pontos_Visitados(context: viewContext)
            newItem.id = UUID()
            newItem.quant_idas = 1
            newItem.user_id = player.gamePlayerID
            newItem.ponto_name = PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.name
            print(newItem)
            print(player.teamPlayerID)
            
            var desafio = Desafios(context: viewContext)
            desafio = desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!
            desafio.state = "Concluido"
            
            do {
                try viewContext.save()
                print(newItem)
                print(desafio)
                unlockAchievement(item: newItem)
                isDetailViewShown.toggle()
            } catch {
            }
        }
    }
    
    private func registraDesafioFracassado () {
        var desafio = Desafios(context: viewContext)
        desafio = desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!
        desafio.state = "Fracassado"
        
        do {
            print(desafio)
            try viewContext.save()
            isDetailViewShown.toggle()
        } catch {
        }
    }
    
    private func unlockAchievement(item: Pontos_Visitados) {
        if item.quant_idas == 1 || item.quant_idas == 3 || item.quant_idas == 5 || item.quant_idas == 10 {
            let achievement = GKAchievement(identifier: "\(transformString(item.ponto_name!))_\(item.quant_idas)")
            achievement.percentComplete = 100
            achievement.showsCompletionBanner = true
            GKAchievement.report([achievement]) { error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                print("done!")
            }
        } else if item.quant_idas < 3 {
            let achievement = GKAchievement(identifier: "\(transformString(item.ponto_name!))_3")
            achievement.percentComplete = Double(item.quant_idas/3 * 100)
            achievement.showsCompletionBanner = true
            GKAchievement.report([achievement]) { error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                print("done!")
            }
        } else if item.quant_idas < 5 {
            let achievement = GKAchievement(identifier: "\(transformString(item.ponto_name!))_5")
            achievement.percentComplete = Double(item.quant_idas/5 * 100)
            GKAchievement.report([achievement]) { error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                print("done!")
            }
        } else if item.quant_idas < 10 {
            let achievement = GKAchievement(identifier: "\(transformString(item.ponto_name!))_10")
            achievement.percentComplete = Double(item.quant_idas/10 * 100)
            GKAchievement.report([achievement]) { error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                print("done!")
            }
        }
        
    }
}

