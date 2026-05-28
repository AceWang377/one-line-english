import SwiftUI

struct ReviewView: View {
    @EnvironmentObject private var appState: AppState
    @State private var mode = 0

    var body: some View {
        NavigationStack {
            ZStack {
                OneLineEnglishBackground()

                VStack(spacing: 16) {
                    Picker(appState.tr("review"), selection: $mode) {
                        Text(appState.tr("quotes")).tag(0)
                        Text(appState.tr("words")).tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 20)

                    if mode == 0 {
                        learnedQuoteList
                    } else {
                        learnedWordList
                    }
                }
                .frame(maxWidth: 760)
                .padding(.top, 12)
            }
            .navigationTitle(appState.tr("review"))
            .sheet(item: $appState.selectedReviewCard) { card in
                ReviewDetailView(card: card)
                    .environmentObject(appState)
            }
            .sheet(item: $appState.shareCard) { card in
                ShareSheet(items: [ShareImageService().image(for: card, isChinese: appState.isChinese)])
            }
        }
    }

    private var learnedQuoteList: some View {
        Group {
            if appState.learnedCards.isEmpty {
                EmptyStateView(systemImage: "rectangle.stack", text: appState.tr("emptyReview"))
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(appState.learnedCards) { card in
                            LearnedQuoteRow(card: card) {
                                appState.selectedReviewCard = card
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 96)
                }
            }
        }
    }

    private var learnedWordList: some View {
        Group {
            if appState.learnedWords.isEmpty {
                EmptyStateView(systemImage: "textformat", text: appState.tr("emptyReview"))
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(appState.learnedWords) { card in
                            Button {
                                appState.selectedReviewCard = card
                            } label: {
                                HStack(alignment: .top, spacing: 14) {
                                    Text(card.highlight.prefix(1).uppercased())
                                        .font(.headline.bold())
                                        .foregroundStyle(.white)
                                        .frame(width: 42, height: 42)
                                        .background(Color.qgCharcoal, in: Circle())

                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(card.highlight)
                                            .font(.headline.bold())
                                            .foregroundStyle(Color.qgInk)
                                        Text(card.meaning.en)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.qgMuted)
                                            .lineLimit(2)
                                    }

                                    Spacer()
                                }
                                .padding(16)
                                .background(Color.qgSurface.opacity(0.94), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .stroke(Color.qgStroke.opacity(0.70), lineWidth: 1)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 96)
                }
            }
        }
    }
}

private struct LearnedQuoteRow: View {
    let card: QuoteCard
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(card.theme)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.qgBlue)
                    Spacer()
                    Text(card.highlight)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.qgMuted)
                }

                Text("“\(card.quoteText)”")
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .foregroundStyle(Color.qgInk)
                    .lineLimit(3)

                Text("— \(card.author)")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color.qgMuted)
            }
            .padding(18)
            .background(Color.qgSurface.opacity(0.94), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.qgStroke.opacity(0.70), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct ReviewDetailView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss
    let card: QuoteCard

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    QuoteCardContentView(card: card, isExpanded: true, isChinese: appState.isChinese)
                        .padding(24)
                        .background(Color.qgSurface, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 26, style: .continuous)
                                .stroke(Color.qgStroke.opacity(0.72), lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(appState.isChinese ? "出处" : "Source")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(Color.qgMuted)
                        Text(card.source.note)
                            .font(.footnote)
                            .foregroundStyle(Color.qgMuted)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(18)
                    .background(Color.qgSurface.opacity(0.82), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.qgStroke.opacity(0.70), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)

                    Button {
                        appState.shareCard = card
                    } label: {
                        Label(appState.tr("share"), systemImage: "square.and.arrow.up")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color.qgAccent, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .foregroundStyle(Color.qgCharcoal)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .background(OneLineEnglishBackground())
            .navigationTitle(card.highlight)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(appState.tr("done")) { dismiss() }
                }
            }
        }
    }
}
