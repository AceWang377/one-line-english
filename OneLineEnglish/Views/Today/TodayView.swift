import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let cardHeight = min(500, max(430, proxy.size.height * 0.52))

                ZStack {
                    OneLineEnglishBackground()

                    VStack(spacing: 14) {
                        header

                        if appState.dailyState.isCompleted {
                            CompletionView()
                        } else if let card = appState.currentTodayCard {
                            deck(card, height: cardHeight)
                            actionBar(card: card)
                        } else {
                            CompletionView()
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 72)
                    .frame(maxWidth: min(680, proxy.size.width - 40))
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle(appState.tr("today"))
            .toolbarTitleDisplayMode(.inline)
            .sheet(item: $appState.shareCard) { card in
                ShareSheet(items: [ShareImageService().image(for: card, isChinese: appState.isChinese)])
            }
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(appState.tr("daily10"))
                    .font(.title2.bold())
                    .foregroundStyle(Color.qgInk)
                Text(appState.dailyProgressText)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.qgMuted)
            }

            Spacer()

            HStack(spacing: 8) {
                Image(systemName: "flame.fill")
                    .foregroundStyle(Color.qgCream)
                Text("\(appState.streakState.currentStreak)")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.qgElevated, in: Capsule())
            .overlay(Capsule().stroke(Color.qgStroke.opacity(0.75), lineWidth: 1))
        }
    }

    private func deck(_ card: QuoteCard, height: CGFloat) -> some View {
        ZStack {
            ForEach(Array(appState.todayCards.prefix(3).enumerated()), id: \.element.id) { index, preview in
                if preview.id != card.id {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(Color.qgSurface.opacity(0.58))
                        .frame(height: height - 16)
                        .scaleEffect(1 - CGFloat(index + 1) * 0.035)
                        .offset(y: CGFloat(index + 1) * 12)
                        .shadow(color: .black.opacity(0.20), radius: 16, y: 10)
                }
            }

            SwipeCardView(card: card, isChinese: appState.isChinese, cardHeight: height) { direction in
                appState.handle(direction, card: card, context: .today)
            }
            .id(card.id)
        }
    }

    private func actionBar(card: QuoteCard) -> some View {
        HStack(spacing: 12) {
            actionButton(title: appState.tr("reviewLater"), icon: "arrow.uturn.left", color: Color(red: 0.70, green: 0.40, blue: 0.18)) {
                appState.markForReview(card, context: .today)
            }
            actionButton(title: appState.tr("share"), icon: "square.and.arrow.up", color: Color.qgBlue) {
                appState.shareCard = card
            }
            actionButton(title: appState.tr("know"), icon: "checkmark", color: Color.qgAccent) {
                appState.markKnown(card, context: .today)
            }
        }
    }

    private func actionButton(title: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.headline.weight(.bold))
                Text(title)
                    .font(.caption.weight(.semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .foregroundStyle(color)
            .background(Color.qgElevated.opacity(0.94), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.qgStroke.opacity(0.70), lineWidth: 1)
            )
        }
        .accessibilityLabel(title)
    }
}
