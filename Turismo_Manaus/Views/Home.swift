//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI

struct Home: View {
    
    @State var isShowingFilterView = false
    
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
                    Button(action: {
                        isShowingFilterView.toggle()
                    }, label: {
                        Image("btn_adjust")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    })
                    
                    
                    //ROLAGEM DE DADOS
                    Image("dice6")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    //ICONES
                    //HStack define a ordem dos itens na horizontal
                    HStack (spacing: 50){
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image("AppIcon29x29 1")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        })
        

                        NavigationLink(destination: Badges()) {
                            Image("AppIcon29x29 2")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                        
                        NavigationLink(destination: Ranking()) {
                            Image("AppIcon29x29 3")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                        
                        NavigationLink(destination: Me()) {
                            Image("AppIcon29x29")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                    
                    }
                }
                .sheet(isPresented: $isShowingFilterView, content: {
                    FilterView()
                })
                //POPUP NA TELA DO LOCAL SPAWMADO
                //CODIGO DO POPUP
                //-----------xxxxx----------
            }
            .padding()
            
        }
    }
}

#Preview {
    Home()
}
