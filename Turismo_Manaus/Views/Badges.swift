//
//  ContentView.swift
//  Turismo_Manaus
//
//  Created by Luan Aiezza on 10/05/24.
//  Created by Luan Aiezza on 10/05/24.
//

import SwiftUI

struct Badges: View {
    @State private var selectedTab: Int = 1
    
    var body: some View {
        //ZStack define a ordem dos itens na layer
        GeometryReader { geometry in
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
                        Text("Conquistas")
                        
                        //ROLAGEM DE DADOS
                        Text("Aqui vai as conquistas")
                        
                        
                        
                    }
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    Badges()
}
