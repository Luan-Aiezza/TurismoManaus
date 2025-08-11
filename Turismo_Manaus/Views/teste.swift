import SwiftUI

struct TesteView: View {
    @State private var isShowing: Bool = false
    @GestureState private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.pink)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue)
            }
            
            // RoundedRectangle do meio que será arrastável
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
                .background(.ultraThinMaterial)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .offset(x: position.width + dragOffset.width,
                        y: position.height + dragOffset.height)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            position.width += value.translation.width
                            position.height += value.translation.height
                        }
                )
                .onTapGesture {
                    isShowing = true
                }
                .sheet(isPresented: $isShowing) {
                    Text("oi")
                        .padding()
                        .presentationBackground(.ultraThinMaterial) // iOS 16+
                }
        }
    }
}

#Preview {
    TesteView()
}
