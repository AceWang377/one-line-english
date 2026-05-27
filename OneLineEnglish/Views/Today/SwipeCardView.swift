import SwiftUI

enum SwipeDirection {
    case left
    case right
    case up
}

struct SwipeCardView: View {
    let card: QuoteCard
    let isChinese: Bool
    var cardHeight: CGFloat = 490
    let onSwipe: (SwipeDirection) -> Void

    @State private var dragOffset: CGSize = .zero
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.qgSurface)
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.qgStroke.opacity(0.82), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.34), radius: 28, y: 18)

            QuoteCardContentView(card: card, isExpanded: isExpanded, isChinese: isChinese)
                .padding(22)

            overlayLabel
        }
        .frame(maxWidth: .infinity)
        .frame(height: cardHeight)
        .contentShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .offset(dragOffset)
        .rotationEffect(.degrees(Double(dragOffset.width / 24)))
        .animation(.spring(response: 0.32, dampingFraction: 0.84), value: dragOffset)
        .onTapGesture {
            isExpanded.toggle()
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation
                }
                .onEnded { value in
                    commit(translation: value.translation, predicted: value.predictedEndTranslation)
                }
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(card.quoteText), \(card.author), \(card.highlight)")
    }

    private var overlayLabel: some View {
        let direction = activeDirection
        return VStack {
            if let direction {
                Text(label(for: direction))
                    .font(.headline.weight(.bold))
                    .foregroundStyle(color(for: direction))
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .background(Color.qgElevated.opacity(0.96), in: Capsule())
                    .overlay(Capsule().stroke(color(for: direction).opacity(0.35), lineWidth: 1))
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: alignment(for: direction))
            }
            Spacer()
        }
        .opacity(activeDirection == nil ? 0 : 1)
    }

    private var activeDirection: SwipeDirection? {
        if dragOffset.height < -70 { return .up }
        if dragOffset.width > 70 { return .right }
        if dragOffset.width < -70 { return .left }
        return nil
    }

    private func commit(translation: CGSize, predicted: CGSize) {
        let horizontal = abs(predicted.width) > abs(translation.width) ? predicted.width : translation.width
        let vertical = abs(predicted.height) > abs(translation.height) ? predicted.height : translation.height

        if vertical < -140 {
            animateOut(.up)
        } else if horizontal > 120 {
            animateOut(.right)
        } else if horizontal < -120 {
            animateOut(.left)
        } else {
            dragOffset = .zero
        }
    }

    private func animateOut(_ direction: SwipeDirection) {
        let target: CGSize
        switch direction {
        case .left: target = CGSize(width: -640, height: 40)
        case .right: target = CGSize(width: 640, height: 40)
        case .up: target = CGSize(width: 0, height: -780)
        }

        withAnimation(.spring(response: 0.28, dampingFraction: 0.88)) {
            dragOffset = target
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            onSwipe(direction)
            dragOffset = .zero
        }
    }

    private func label(for direction: SwipeDirection) -> String {
        switch direction {
        case .left: return isChinese ? "稍后复习" : "Review later"
        case .right: return isChinese ? "我会了" : "I know it"
        case .up: return isChinese ? "分享" : "Share"
        }
    }

    private func color(for direction: SwipeDirection) -> Color {
        switch direction {
        case .left: return .orange
        case .right: return Color.qgAccent
        case .up: return Color.qgBlue
        }
    }

    private func alignment(for direction: SwipeDirection) -> Alignment {
        switch direction {
        case .left: return .topLeading
        case .right: return .topTrailing
        case .up: return .top
        }
    }
}
