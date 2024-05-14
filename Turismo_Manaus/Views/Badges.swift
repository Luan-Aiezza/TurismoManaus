import SwiftUI
import GameKit

struct GameCenterAchievementsView: View {
    @State private var isPresentingGameCenter = false
    
    var body: some View {
        Button("Show Achievements") {
            isPresentingGameCenter = true
        }
        .sheet(isPresented: $isPresentingGameCenter, onDismiss: {}) {
            GameCenterAchievementsViewControllerWrapper()
        }
    }
}
