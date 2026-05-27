import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var appState: AppState

    private var pages: [(String, String)] {
        if appState.isChinese {
            return [
                ("rectangle.stack.fill", "滑动英文金句卡片"),
                ("sparkle.magnifyingglass", "每张卡记住一个高价值单词"),
                ("flame.fill", "每天学习一句，建立连续性")
            ]
        }
        return [
            ("rectangle.stack.fill", "Swipe through one-line English cards."),
            ("sparkle.magnifyingglass", "Learn one useful word from each quote."),
            ("flame.fill", "Complete one line a day and build your streak.")
        ]
    }

    var body: some View {
        VStack(spacing: 24) {
            TabView {
                ForEach(pages, id: \.1) { page in
                    VStack(spacing: 28) {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 108, height: 108)
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .shadow(color: .black.opacity(0.46), radius: 26, y: 16)

                        Text(page.1)
                            .font(.system(size: 31, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.qgInk)
                            .padding(.horizontal, 28)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .tabViewStyle(.page)

            Button {
                appState.finishOnboarding()
            } label: {
                Text(appState.tr("start"))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.qgAccent, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .foregroundStyle(Color.qgCharcoal)
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 28)
        }
        .background(OneLineEnglishBackground())
    }
}
