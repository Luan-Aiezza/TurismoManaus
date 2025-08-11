

import SwiftUI
import SceneKit
import GameKit
import CoreLocation
import Foundation

struct OnboardingPage2: View {
    
    var body: some View {
        
        VStack(spacing: 80){
            Text("Utilize o filtro para personalizar seu desafio ou Ignore o filtro e sorteie às cegas")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            HStack{
                Image("Group1516")
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

