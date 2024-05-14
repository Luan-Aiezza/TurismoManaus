//
//  TabBar.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 14/05/24.
//

import SwiftUI

enum Tabs: Int {
    case dice = 0
    case achievement = 1
    case ranking = 2
    case me = 3
}

struct TabBar: View {
    
    var body: some View {
        
//        @State private var selectTab: Int = 0
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .frame(width: 358, height: 70) // Ajuste o tamanho conforme necessário
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack (alignment: .center, spacing: 40){
                Button(action: {
                    
                }, label: {
                    VStack{
                        Image(systemName: "dice.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                        
                    }
                })
                
                Button(action: {
                    
                }, label: {
                    VStack{
                        Image(systemName: "rosette")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .tint(.gray)

                    }
                    
                })
                
                Button(action: {
                    
                }, label: {
                    VStack (alignment: .center, spacing: 10){
                        Image(systemName: "crown.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                            .tint(.gray)
                    }
                })
                
                Button(action: {
                    
                }, label: {
                    VStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                            .tint(.gray)

                    }
                })
            }
            .padding(20)
            
        }
    }
}

#Preview {
    TabBar()
}
