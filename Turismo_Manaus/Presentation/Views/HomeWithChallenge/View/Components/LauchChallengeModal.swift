//
//  LauchChallengeModal.swift
//  Simbora Manaus
//
//  Created by Italo Guilherme Monte on 11/08/25.
//

import SwiftUI

struct LauchChallengeModal: View {
    
    @EnvironmentObject var vm: HomeWithChallengeViewModel
    let point: PontoTuristico
    let desafios: FetchedResults<Desafios>
    
    var body: some View {
        if desafios.contains(where: { $0.state == "inProgress" && $0.user_id == vm.player.gamePlayerID }) {
            ZStack {
                Color.black
                    .opacity(0.8)
                
                VStack(spacing: 12) {
                    Text("Desafio lançado!")
                        .font(.title)
                    Text("Visite o(a) \( Text(point.name).bold())  pela primeira vez no prazo de 1 semana.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Image(point.imageName)
                        .resizable()
                        .scaledToFit()
                        .scaledToFill()
                        .frame(width: 358, height: 176)
                        .cornerRadius(15.0)
                        .padding(.vertical, 24.0)
                    
                    HStack{
                        
                        // Aceitar
                        Button(action: {
                            vm.isShowingModal = false
                        }
                               , label: {
                            ZStack {
                                
                                HStack {
                                    Text("Ok")
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
            ZStack {
                Color.black
                    .opacity(0.8)
                VStack(spacing: 12) {
                    Text("Desafio lançado!")
                        .font(.title)
                    Text("Visite o(a) \( Text(point.name).bold())  pela primeira vez no prazo de 1 semana.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Image(point.imageName)
                        .resizable()
                        .scaledToFit()
                        .scaledToFill()
                        .frame(width: 358, height: 176)
                        .cornerRadius(15.0)
                        .padding(.vertical, 24.0)
                    
                    HStack{
                        // Recusar
                        Button(action: {
                            vm.isShowingModal = false
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
                            vm.addChallenge(pontoId: transformString(point.name))
                            vm.isShowingModal = false
                        },
                        label: {
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
        }
    }
}
