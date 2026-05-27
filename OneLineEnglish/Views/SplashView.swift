import SwiftUI

struct SplashView: View {
    @State private var logoVisible = false

    var body: some View {
        ZStack {
            Color.qgCharcoal.ignoresSafeArea()

            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 148, height: 148)
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                .shadow(color: .black.opacity(0.32), radius: 28, y: 18)
                .opacity(logoVisible ? 1 : 0)
                .scaleEffect(logoVisible ? 1 : 0.94)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.55)) {
                logoVisible = true
            }
        }
    }
}
