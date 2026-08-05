import SwiftUI

@main
struct PitchChartAppApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Matches the web app's --bg in each theme, so the status bar
                // area doesn't sit as a dark band above a light page.
                Color.appBackground.ignoresSafeArea()
                ContentView()
                    .ignoresSafeArea(.container, edges: .bottom)
            }
        }
    }
}

extension Color {
    static let appBackground = Color(UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0x07/255, green: 0x0F/255, blue: 0x0C/255, alpha: 1)
            : UIColor(red: 0xF4/255, green: 0xF2/255, blue: 0xED/255, alpha: 1)
    })
}
