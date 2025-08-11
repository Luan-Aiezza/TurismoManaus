//
//  LoadingView.swift
//  Turismo_Manaus
//
//  Created by Italo Guilherme Monte on 27/05/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Image(.appIcon29X29)
                    .resizable()
                    .frame(width: 160, height: 160)
            }
        }
    }
}
#Preview {
    LoadingView()
}
