import SwiftUI

struct Carrossel: View {
    
    @Binding var currentIndex: Int
    @State var dragOfset: CGFloat = 0
    
    var body: some View {
        VStack{
            ZStack {
                ForEach(Array(PontosTuristicos.enumerated()), id: \.offset) { index, ponto in
                    let isCurrent = (currentIndex == index)  // Changed from currentIndex.wrappedValue
                    let offsetX = CGFloat(index - currentIndex) * 300 + dragOfset
                    let scale: CGFloat = isCurrent ? 1.0 : 0.8
                    let opacity: Double = isCurrent ? 1.0 : 0.5
                    
                    CardPoint(point: ponto)
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .offset(x: offsetX)
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded({ value in
                    let threshold: CGFloat = 50
                    
                    //arrastando pra esquerda
                    if value.translation.width < -threshold {  // Fixed condition
                        withAnimation {
                            currentIndex = ((currentIndex + 1) % PontosTuristicos.count)
                            print("aqui", currentIndex)
                        }
                    }
                    
                    //arrastando pra direita
                    else if value.translation.width > threshold {
                        withAnimation {
                            if currentIndex == 0 {
                                currentIndex = PontosTuristicos.count - 1
                            } else {
                                currentIndex = currentIndex - 1
                            }
                            print(currentIndex)
                        }
                    }
                })
        )
    }
}
