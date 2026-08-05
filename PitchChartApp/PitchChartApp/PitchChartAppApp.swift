import SwiftUI

@main
struct PitchChartAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .ignoresSafeArea(.container, edges: .bottom)
                .preferredColorScheme(.dark)
        }
    }
}
