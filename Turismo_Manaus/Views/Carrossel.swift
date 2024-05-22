import SwiftUI

struct CardPoint: View {
    var name: String
    @Binding var isShowingModal: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 300, height: 300)
                .foregroundStyle(Color.green)
            Text(name)
                .foregroundColor(.white)
                .font(.title)
                .frame(width: 250)
        }
        .onTapGesture {
            isShowingModal.toggle()
        }
        
    }
}


struct Carrossel: View {
    
    @Binding var currentIndex: Int
    @Binding var isShowingModal: Bool
    @State var dragOfset: CGFloat = 0

    var body: some View {
        VStack{
            ZStack{
                ForEach(0 ..< PontosTuristicos.count, id: \.self) { index in
                    CardPoint(name: PontosTuristicos[index].name, isShowingModal: $isShowingModal)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .offset(x: CGFloat(index - currentIndex) * 300 + dragOfset)
                    
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
}


//
//struct Carrossel: View {
//    @State private var cardCenters: [CGFloat] = []
//    @State private var selectedCardIndex: Int? = nil
//    
//    var body: some View {
//        GeometryReader { outerGeometry in
//            let midX = outerGeometry.frame(in: .global).midX
//            VStack{
//                ScrollViewReader { scrollViewProxy in
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 40) {
//                            ForEach(PontosTuristicos.indices, id: \.self) { index in
//                                GeometryReader { innerGeometry in
//                                    let cardMidX = innerGeometry.frame(in: .global).midX
//                                    let isCentered = abs(cardMidX - midX) < 180
//                                    
//                                    CardPoint(name: PontosTuristicos[index].name, isCentered: isCentered)
//                                        .id(index)
//                                        .onChange(of: isCentered) {
//                                            if isCentered {
//                                                selectedCardIndex = index
//                                                withAnimation {
//                                                    scrollViewProxy.scrollTo(index, anchor: .center)
//                                                }
//                                            }
//                                        }
//                                }
//                                .frame(width: 300)
//                            }
//                        }
//                        .padding()
//                        .background(Color.clear)
//                        
//                    }
//                }
//            }
//        }
//    }
//}

