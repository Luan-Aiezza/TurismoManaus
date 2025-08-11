

import SwiftUI
import SceneKit
import GameKit
import CoreLocation
import Foundation

struct OnboardingPage3: View {
    var body: some View {
        VStack(spacing: 60){
            Text("Você também pode visualizar suas conquistas no seu perfil Game Center")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            HStack{
                Image("Group1519")
            }
        }
    }
}


