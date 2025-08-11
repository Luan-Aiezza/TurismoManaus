
import SwiftUI

struct OnboardingPage1: View {
    var body: some View {
        VStack(spacing: 80){
            
            Text("Bem-vindo(a) ao Simbora Manaus! Seja desafiado a visitar os pontos turísticos de Manaus!")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            HStack{
                Image("Group1515")
                    .padding()
            }
        }
    }
}
