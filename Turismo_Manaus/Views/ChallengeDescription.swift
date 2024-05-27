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

struct ChallengeDescription: View {
    @Binding var isDetailViewShown: Bool 
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default)
    private var desafios: FetchedResults<Desafios>
    @State var player = GKLocalPlayer.local
    @State var preco = "$$"
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
                .onAppear {
                    calculaPreco()
                }
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
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("\( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.desc)")
                        .foregroundStyle(.white)
                        .font(.body)
                        .padding(.top, 16.0)
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
                    
                    Text("Av. Eduardo ribeiro - Centro, Manaus - AM, 69010-000")
                        .foregroundStyle(.white)
                        .padding(.vertical,24.0)
                        .font(.body)
                })
                
                HStack {
                    ZStack {
                        
                        HStack {
                            Image(systemName: "arrow.up.right.square")
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
                    
                    Spacer()
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
                }
                ZStack {
                    
                    HStack {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                        Text("Desistir")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal,130.0)
                    .padding(.vertical,12.0)
                }.background(Color.redGlass)
                    .cornerRadius(100.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100.0)
                            .stroke(Color.redGlass, lineWidth: 2)
                    )
                    .padding(.top, 16.0)
            }
            .padding(16.0)
        }
    }
    
    func calculaPreco () {
        if (PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.preco) == Precos.barato {
            preco = "$"
        } else if (PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.preco) == Precos.medio {
            preco = "$$"
        } else {
            preco = "$$$"
        }
    }
}

