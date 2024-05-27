//
//  ChallengeCard.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 23/05/24.
//

import SwiftUI
import GameKit


struct ChallengeCard: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Desafios.id, ascending: true)],
        animation: .default)
    private var desafios: FetchedResults<Desafios>
    @State var player = GKLocalPlayer.local
    @State var dias = 2
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        if desafios.contains(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID }) {
            ZStack {
                VStack {
                    HStack{
                        Spacer()
                        Image( transformString(desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id!) )
                            .resizable()
                            .frame(width: 48, height: 63)
                            .scaledToFit()
                            .cornerRadius(16.0)
                        VStack (alignment: .leading, content: {
                            Text("Visite o(a) \( PontosTuristicos.first(where: { transformString($0.name)  == desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.ponto_id! })!.name) pela primeira vez")
                                .font(.system(size: 15.0))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                            if dias > 1 {
                                Text("\(dias) dias restantes")
                                    .font(.system(size: 12.0))
                                    .foregroundColor(.neutral)
                            } else {
                                Text("\(dias) dia restante")
                                    .font(.system(size: 12.0))
                                    .foregroundColor(.neutral)
                            }
                        })
                        .padding(.horizontal, 12.0 )
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .frame(width: 11.689, height: 16.963)
                            .scaledToFit()
                        Spacer()
                        //
                    }
                    .padding(12)
                }
            }.overlay(
                RoundedRectangle(cornerRadius: 24.0)
                    .stroke(Color.bgGlass1, lineWidth: 2)
            )
            .frame(maxWidth: .infinity)
            .background(Color.bgGlass1)
            .cornerRadius(24.0)
            .onAppear {
                dias = Int(desafios.first(where: { $0.state == "inProgress" && $0.user_id == player.gamePlayerID })!.data_termino!.timeIntervalSince(Date()) / (60 * 60 * 24))
            }
        }
    }
    
}


