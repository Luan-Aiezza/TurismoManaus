import SwiftUI

struct CardPointSelected: View {
    var name: String
    

    var body: some View {
        ZStack {
            Color.teste
                .cornerRadius(24.0)
            Image(transformString(name))
                .resizable()
                .frame(width: 300, height: 342)
                .scaledToFit()
                .cornerRadius(24.0)
            VStack {
                Spacer()
                Text(name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(width: 250)
                    
            }
            .padding(16.0)
        }
        .frame(width: 316, height: 358)
            .overlay(
                RoundedRectangle(cornerRadius: 24.0)
                    .stroke(Color.bgGlass1, lineWidth: 2)
                    )

        
        
    }
}

struct CardPoint: View {
    var name: String
    

    var body: some View {
        ZStack {
            
            Image(transformString(name))
                .resizable()
                .scaledToFit()
            VStack {
                Spacer()
                Text(name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(width: 250)
            }
        }
        .cornerRadius(15.0)
        .frame(width: 300, height: 342)
        
    }
}




struct Carrossel: View {
    
    @Binding var currentIndex: Int
    
    
    @State var dragOfset: CGFloat = 0

    var body: some View {
        VStack{
            ZStack{
                ForEach(0 ..< PontosTuristicos.count, id: \.self) { index in
                    if index == currentIndex {
                        CardPointSelected(name: PontosTuristicos[index].name)
                            .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOfset)
                    } else {
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

