import SwiftUI

struct RootTabView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            TodayView()
                .tabItem { Label(appState.tr("today"), systemImage: "sun.max.fill") }
                .tag(AppTab.today)

            ReviewView()
                .tabItem { Label(appState.tr("review"), systemImage: "arrow.triangle.2.circlepath") }
                .tag(AppTab.review)

            SettingsView()
                .tabItem { Label(appState.tr("settings"), systemImage: "gearshape.fill") }
                .tag(AppTab.settings)
        }
        .tint(Color.qgAccent)
        .preferredColorScheme(.dark)
        .toolbarBackground(Color.qgBackground, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
}
