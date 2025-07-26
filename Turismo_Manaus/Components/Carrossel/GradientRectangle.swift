
//
//  CarrosselPointSelected.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 26/07/25.
//

import SwiftUI

struct GradientRectangle : View {
    
    var body: some View {
        // Gradiente para simular o efeito de vidro fosco
        LinearGradient(gradient: Gradient(colors: [Color.clear.opacity(1), Color.clear.opacity(1),Color.clear.opacity(1), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom)
            .frame(width: 300, height: 342) // Ajuste o tamanho conforme necessário
            .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
