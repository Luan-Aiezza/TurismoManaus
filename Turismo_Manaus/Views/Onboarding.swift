import SwiftUI
import SceneKit
import GameKit
import CoreLocation
import Foundation

struct OnboardingView: View {
    @State private var currentPage = 0
    @Binding var hasCompletedOnboarding:  Bool
    
    var body: some View {
        ZStack{
            Color.backgroundColor
                .ignoresSafeArea()
            VStack {
                if currentPage == 0 {
                    OnboardingPage1()
                        .padding(115)
                } else if currentPage == 1 {
                    OnboardingPage2()
                        .padding(76)
                } else {
                    OnboardingPage3()
                        .padding(40)
                }
                Button(action: {
                    if currentPage < 2 {
                        currentPage += 1
                    } else {
                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                        hasCompletedOnboarding = true
                    }
                }) {
                    ZStack {
                        Color.bgGlass1
                            .cornerRadius(100.0)
                        Text(currentPage < 2 ? "Continuar" : "Concluir")
                            .font(.headline)
                            .foregroundColor(.accentColorYellow)
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 12.0)
                    }
                    .frame(width: 150, height: 46)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100.0)
                            .stroke(Color.bgGlass1, lineWidth: 2)
                    )
                }
            }
        }
    }
}

struct OnboardingPage1: View {
    var body: some View {
        VStack(spacing: 100){
            
            Text("Bem-vindo(a) ao Simbora Manaus!\nSeja desafiado a visitar os pontos turísticos de Manaus!")
                .foregroundColor(.white)
            HStack{
                Image("Group1515")
                    .padding()
            }
        }
    }
}

struct OnboardingPage2: View {
    
    var body: some View {
        
        VStack(spacing: 80){
            Text("Utilize o filtro para personalizar seu desafio\nou\nIgnore o filtro e sorteie às cegas")
                .foregroundColor(.white)
            HStack{
                Image("Group1516")
            }
        }
    }
}

struct OnboardingPage3: View {
    var body: some View {
        VStack(spacing: 60){
            Text("Você também pode visualizar suas \nconquistas no seu perfil Game Center")
                .foregroundColor(.white)
            HStack{
                Image("Group1519")
            }
        }
    }
}

struct ContentView: View {
    @State var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    var body: some View {
        if !hasCompletedOnboarding {
            OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
        } else {
            UI()
        }
    }
}

