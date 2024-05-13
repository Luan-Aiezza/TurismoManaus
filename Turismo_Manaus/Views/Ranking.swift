//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI

struct Ranking: View {
    var body: some View {
        //ZStack define a ordem dos itens na layer
        NavigationStack {
            ZStack{
                //FUNDO
                //CODIGO DE FUNDO
                Image("background_1")
                    .imageScale(.large)
                    .foregroundStyle(.brown)
                //VStack define a ordem dos itens na vertical
                VStack (spacing: 250){//spacing é um parametro de espacamento geral entre os itens
                    //FILTROS
                    Image("btn_adjust")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    //ROLAGEM DE DADOS
                    Image("dice6")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    
                    
                
                }

            }
            .padding()
        }
    }
}

#Preview {
    Ranking()
}
