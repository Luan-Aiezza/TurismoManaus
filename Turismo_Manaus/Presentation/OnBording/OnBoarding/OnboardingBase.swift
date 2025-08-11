
import SwiftUI
import SceneKit
import GameKit
import CoreLocation
import Foundation


struct OnboardingBase: View {
    
    @StateObject var vm: OnBoardingViewModel = .init()

    @Binding var hasCompletedOnboarding:  Bool
    
    var body: some View {
        ZStack{
            Color.backgroundColor
                .ignoresSafeArea()
            VStack {
                if vm.currentPage == 0 {
                    OnboardingPage1()
                        .padding(115)
                } else if vm.currentPage == 1 {
                    OnboardingPage2()
                        .padding(76)
                } else {
                    OnboardingPage3()
                        .padding(40)
                }
                Button(action: {
                    if vm.currentPage < 2 {
                        vm.currentPage += 1
                    } else {
                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                        hasCompletedOnboarding = true
                    }
                }) {
                    ZStack {
                        Color.bgGlass1
                            .cornerRadius(100.0)
                        Text(vm.currentPage < 2 ? "Continuar" : "Concluir")
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
