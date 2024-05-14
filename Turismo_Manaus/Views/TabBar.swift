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
    
    @Binding var selectTab: Tabs

    var body: some View {
            
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .frame(width: 358, height: 70) // Ajuste o tamanho conforme necessário
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack (alignment: .center, spacing: 40){
                Button(action: {
                    selectTab = .dice
                }, label: {
                    VStack{
                        var dice = Image(systemName: "dice.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                        if selectTab == .dice {
                            dice
                        } else {
                            dice
                                .tint(.gray)
                        }
                        
                    }
                })
                
                Button(action: {
                    selectTab = .achievement
                }, label: {
                    VStack{
                        var achievement =  Image(systemName: "rosette")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        
                        if selectTab == .achievement {
                            achievement
                        } else {
                            achievement
                                .tint(.gray)
                        }
                    }
                    
                })
                
                Button(action: {
                    selectTab = .ranking

                }, label: {
                    VStack (alignment: .center, spacing: 10){
                        
                        var ranking = Image(systemName: "crown.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                        
                        if selectTab == .ranking {
                            ranking
                        } else {
                            ranking
                                .tint(.gray)
                        }
                    }
                })
                
                Button(action: {
                    selectTab = .me
                }, label: {
                    VStack{
                        var me = Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                            
                        
                        if selectTab == .me {
                            me
                        } else {
                            me
                                .tint(.gray)
                        }
                    }
                })
            }
            .padding(20)
            
        }
    }
}

#Preview {
    TabBar(selectTab: .constant(.dice))
}
