//
//  ChallengeCard.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 23/05/24.
//

import SwiftUI
import GameKit


struct ChallengeCard: View {
    
   @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
            VStack {
                HStack{
                    Spacer()
                    Image(.card1)
                        .resizable()
                        .frame(width: 48, height: 63)
                        .scaledToFit()
                    Spacer()
                    VStack (alignment: .leading, content: {
                        Text("Visite o Teatro Amazonas pela primeira vez")
                            .font(.system(size: 15.0))
                            .foregroundColor(.white)
                        Text("2 dias restantes")
                            .font(.system(size: 12.0))
                            .foregroundColor(.neutral)
                    })
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .frame(width: 11.689, height: 16.963)
                        .scaledToFit()
                        Spacer()
                    //
                }
                .padding(12)
            }
            .background(Color.bgGlass1)
            .cornerRadius(24.0)
       
    }
        
    }

#Preview {
    ChallengeCard()
}
