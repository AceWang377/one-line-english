import SwiftUI

struct QuoteCardContentView: View {
    let card: QuoteCard
    let isExpanded: Bool
    let isChinese: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(card.theme)
                    .font(.caption.weight(.bold))
                    .textCase(.uppercase)
                    .foregroundStyle(Color.qgCream)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(Color.qgCream.opacity(0.12), in: Capsule())
                    .overlay(Capsule().stroke(Color.qgCream.opacity(0.16), lineWidth: 1))
                Spacer()
                Text(card.level)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.qgMuted)
            }

            quoteText
                .font(.system(size: 27, weight: .regular, design: .serif))
                .lineSpacing(5)
                .foregroundStyle(Color.qgInk)
                .fixedSize(horizontal: false, vertical: true)
                .minimumScaleFactor(0.74)

            Text("— \(card.author)")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color.qgMuted)

            VStack(alignment: .leading, spacing: 6) {
                Text(card.highlight)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.qgAccent)
                Text(card.meaning.en)
                    .font(.callout)
                    .foregroundStyle(Color.qgInk)
            }
            .padding(.top, 2)

            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    detailRow(title: isChinese ? "词性" : "Part of speech", value: card.partOfSpeech)
                    detailRow(title: isChinese ? "记忆点" : "Memory hook", value: card.memoryHook.en)
                    detailRow(title: isChinese ? "常用表达" : "Expression", value: card.expression.en)
                    detailRow(title: isChinese ? "例句" : "Example", value: card.example.en)
                }
                .padding(14)
                .background(Color.qgPaper, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
        }
    }

    private var quoteText: Text {
        let parts = card.quoteParts
        return Text("“\(parts.before)")
            + Text(parts.highlight).foregroundColor(Color.qgAccent).bold()
            + Text("\(parts.after)”")
    }

    private func detailRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption.weight(.bold))
                .foregroundStyle(Color.qgMuted)
            Text(value)
                .font(.callout)
                .foregroundStyle(Color.qgInk)
        }
    }
}

struct OneLineEnglishBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.030, green: 0.035, blue: 0.045),
                    Color(red: 0.070, green: 0.085, blue: 0.095),
                    Color(red: 0.045, green: 0.060, blue: 0.065)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [
                    Color.qgAccent.opacity(0.18),
                    Color.clear
                ],
                center: .topTrailing,
                startRadius: 40,
                endRadius: 360
            )
        }
        .ignoresSafeArea()
    }
}

extension Color {
    static let qgBackground = Color(red: 0.030, green: 0.035, blue: 0.045)
    static let qgCharcoal = Color(red: 0.055, green: 0.065, blue: 0.075)
    static let qgSurface = Color(red: 0.095, green: 0.110, blue: 0.120)
    static let qgElevated = Color(red: 0.130, green: 0.150, blue: 0.160)
    static let qgStroke = Color(red: 0.235, green: 0.270, blue: 0.285)
    static let qgAccent = Color(red: 0.570, green: 0.720, blue: 0.705)
    static let qgBlue = Color(red: 0.515, green: 0.610, blue: 0.700)
    static let qgCream = Color(red: 0.890, green: 0.855, blue: 0.780)
    static let qgInk = Color(red: 0.930, green: 0.925, blue: 0.900)
    static let qgMuted = Color(red: 0.640, green: 0.675, blue: 0.675)
    static let qgPaper = Color(red: 0.115, green: 0.135, blue: 0.145)
}
