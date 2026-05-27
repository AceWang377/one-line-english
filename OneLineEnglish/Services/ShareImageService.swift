import SwiftUI
import UIKit

struct ShareImageService {
    func image(for card: QuoteCard, isChinese: Bool) -> UIImage {
        let size = CGSize(width: 1080, height: 1350)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            UIColor(red: 0.030, green: 0.035, blue: 0.045, alpha: 1).setFill()
            context.fill(rect)

            let cardRect = rect.insetBy(dx: 86, dy: 110)
            let path = UIBezierPath(roundedRect: cardRect, cornerRadius: 42)
            UIColor(red: 0.095, green: 0.110, blue: 0.120, alpha: 1).setFill()
            path.fill()

            let accent = UIColor(red: 0.570, green: 0.720, blue: 0.705, alpha: 1)
            let textColor = UIColor(red: 0.930, green: 0.925, blue: 0.900, alpha: 1)
            let muted = UIColor(red: 0.640, green: 0.675, blue: 0.675, alpha: 1)

            draw(card.theme.uppercased(), in: CGRect(x: 140, y: 170, width: 800, height: 48), font: .systemFont(ofSize: 30, weight: .semibold), color: accent)
            draw("“\(card.quoteText)”", in: CGRect(x: 140, y: 280, width: 800, height: 470), font: .serif(size: 58, weight: .regular), color: textColor)
            draw("— \(card.author)", in: CGRect(x: 140, y: 770, width: 800, height: 64), font: .systemFont(ofSize: 34, weight: .medium), color: muted)
            draw(card.highlight, in: CGRect(x: 140, y: 920, width: 800, height: 60), font: .systemFont(ofSize: 54, weight: .bold), color: accent)
            draw(card.meaning.en, in: CGRect(x: 140, y: 990, width: 800, height: 100), font: .systemFont(ofSize: 34, weight: .regular), color: textColor)
            draw("One Line English", in: CGRect(x: 140, y: 1160, width: 800, height: 44), font: .systemFont(ofSize: 28, weight: .semibold), color: muted)
        }
    }

    private func draw(_ text: String, in rect: CGRect, font: UIFont, color: UIColor) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        style.alignment = .left
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: style
        ]
        text.draw(with: rect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
    }
}

private extension UIFont {
    static func serif(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        UIFont(name: "Georgia", size: size) ?? .systemFont(ofSize: size, weight: weight)
    }
}
