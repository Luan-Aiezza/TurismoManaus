//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //ZStack define a ordem dos itens na layer
        ZStack{
            //FUNDO
            //CODIGO DE FUNDO
            Image("background_1")
                .imageScale(.large)
                .foregroundStyle(.tint)
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
                
                //ICONES
                //HStack define a ordem dos itens na horizontal
                HStack{
                    Image("AppIcon29x29")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Image("AppIcon29x29 1")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Image("AppIcon29x29 2")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Image("AppIcon29x29 3")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
            }
            //POPUP NA TELA DO LOCAL SPAWMADO
            //CODIGO DO POPUP
            //-----------xxxxx----------
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
