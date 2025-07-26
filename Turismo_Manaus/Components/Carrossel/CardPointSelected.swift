//
//  CarrosselPointSelected.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 26/07/25.
//

import SwiftUI

struct CardPoint: View {
    var point: PontoTuristico
    
    var body: some View {
        ZStack {
            Color.teste
                .cornerRadius(24.0)
            Image(point.imageName)
                .resizable()
                .frame(width: 300, height: 342)
                .scaledToFill()
                .scaledToFit()
                .cornerRadius(24.0)
            GradientRectangle()

            VStack {
                Spacer()
                Text(point.name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 290)
                    .multilineTextAlignment(.center)
                
            }
            .padding(16.0)
        }
        .frame(width: 316, height: 358)
        .overlay(
            RoundedRectangle(cornerRadius: 24.0)
                .stroke(Color.bgGlass1, lineWidth: 2)
        )
    }
}

