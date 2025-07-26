import SwiftUI



struct Carrossel: View {
    
    @Binding var currentIndex: Int
    @State var dragOfset: CGFloat = 0
    
    var body: some View {
        VStack{
            ZStack{
                ForEach(0 ..< PontosTuristicos.count, id: \.self) { index in
                    CardPoint(name: PontosTuristicos[index].name)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .offset(x: CGFloat(index - currentIndex) * 300 + dragOfset)
                }
                
            }
        }
        .gesture(
            DragGesture()
                .onEnded({ value in
                    let threshold: CGFloat = 50
                    
                    //arrastando pra esquerda
                    if value.translation.width < threshold {
                        withAnimation {
                            currentIndex =  ((currentIndex + 1) % PontosTuristicos.count)
                            print("aqui", currentIndex)
                            
                        }
                    }
                    
                    //arrastando pra direita
                    else if value.translation.width  > threshold {
                        withAnimation {
                            if currentIndex == 0 {currentIndex = PontosTuristicos.count - 1}
                            else{
                                currentIndex = currentIndex - 1
                                
                            }
                            print(currentIndex)
                        }
                    }
                })
        )
    }
}

