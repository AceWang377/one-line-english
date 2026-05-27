import SwiftUI

@main
struct OneLineEnglishApp: App {
    @StateObject private var appState = AppState()
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                Group {
                    if appState.onboardingCompleted {
                        RootTabView()
                    } else {
                        OnboardingView()
                    }
                }
                .opacity(showSplash ? 0 : 1)

                if showSplash {
                    SplashView()
                        .transition(.opacity)
                }
            }
            .environmentObject(appState)
            .preferredColorScheme(.dark)
            .task {
                try? await Task.sleep(for: .milliseconds(1250))
                withAnimation(.easeInOut(duration: 0.55)) {
                    showSplash = false
                }
            }
        }
    }
}
