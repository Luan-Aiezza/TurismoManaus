//
//  LoadingView.swift
//  Turismo_Manaus
//
//  Refatorada para MVVM - Usa LoadingViewModel
//

import SwiftUI

struct LoadingView: View {
    @StateObject private var viewModel = LoadingViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Logo da aplicação
                Image(.appIcon29X29)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaleEffect(viewModel.isLoading ? 1.0 : 1.1)
                    .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: viewModel.isLoading)
                
                VStack(spacing: 16) {
                    // Mensagem de loading
                    Text(viewModel.loadingMessage)
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    // Barra de progresso
                    if viewModel.isLoading {
                        VStack(spacing: 8) {
                            ProgressView(value: viewModel.loadingProgress)
                                .progressViewStyle(LinearProgressViewStyle(tint: .accentColorYellow))
                                .frame(width: 200)
                            
                            Text("\(Int(viewModel.loadingProgress * 100))%")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // Indicador de erro
                    if viewModel.hasError {
                        VStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                                .font(.largeTitle)
                            
                            Text(viewModel.errorMessage)
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Button("Tentar Novamente") {
                                viewModel.reload()
                            }
                            .buttonStyle(PrimaryButtonStyle())
                        }
                    }
                }
                .frame(height: 120) // Mantém espaço consistente
            }
        }
        .onAppear {
            viewModel.performInitialLoad()
        }
    }
}

// MARK: - Custom Button Style
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .font(.headline)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.accentColorYellow)
            .cornerRadius(25)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    LoadingView()
}
