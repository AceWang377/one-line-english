import SwiftUI

struct CompletionView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: 18) {
            Spacer(minLength: 20)

            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 58, weight: .bold))
                .foregroundStyle(Color.qgAccent)

            Text(appState.tr("completedTitle"))
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.qgInk)

            Text(appState.tr("completedBody"))
                .font(.body)
                .foregroundStyle(Color.qgMuted)

            VStack(spacing: 12) {
                stat(label: appState.tr("currentStreak"), value: "\(appState.streakState.currentStreak)")
                stat(label: appState.tr("reviewLaterCount"), value: "\(appState.learnedCards.count)")
            }
            .padding(20)
            .background(Color.qgSurface.opacity(0.94), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.qgStroke.opacity(0.72), lineWidth: 1)
            )

            Button {
                appState.selectedTab = .review
            } label: {
                Text(appState.tr("review"))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.qgAccent, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .foregroundStyle(.white)
            }

            Spacer()
        }
        .padding(.horizontal, 8)
    }

    private func stat(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(Color.qgMuted)
            Spacer()
            Text(value)
                .font(.headline.bold())
                .foregroundStyle(Color.qgInk)
        }
    }
}
