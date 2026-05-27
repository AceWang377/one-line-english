import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showResetConfirmation = false

    var body: some View {
        NavigationStack {
            List {
                Section(appState.tr("language")) {
                    Picker(appState.tr("language"), selection: Binding(
                        get: { appState.appLanguage },
                        set: { appState.setLanguage($0) }
                    )) {
                        ForEach(AppLanguage.allCases) { language in
                            Text(language.displayName).tag(language)
                        }
                    }
                    .pickerStyle(.segmented)

                    Label(appState.tr("learningEnglishOnly"), systemImage: "textformat.abc")
                    Label(appState.isChinese ? "无需账号，无后端，进度仅保存在本机。" : "No account. No backend. Local progress only.", systemImage: "lock.fill")
                }

                Section {
                    NavigationLink {
                        Text("One Line English\n\nOne line a day. One useful word.")
                            .multilineTextAlignment(.center)
                            .font(.title3.weight(.semibold))
                            .padding()
                    } label: {
                        Label(appState.tr("about"), systemImage: "info.circle")
                    }

                    NavigationLink {
                        PolicyInfoView(
                            title: appState.tr("privacy"),
                            message: appState.isChinese
                                ? "One Line English 不收集个人数据，不包含账号系统、广告 SDK 或第三方分析。学习进度、语言偏好和复习状态仅保存在本机。删除 App 或重置进度会清除本机学习记录。"
                                : "One Line English does not collect personal data and does not include accounts, ad SDKs, or third-party analytics. Learning progress, language preference, and review state are stored only on this device. Deleting the app or resetting progress clears local learning records."
                        )
                    } label: {
                        Label(appState.tr("privacy"), systemImage: "hand.raised.fill")
                    }

                    NavigationLink {
                        PolicyInfoView(
                            title: appState.tr("contact"),
                            message: appState.isChinese
                                ? "如需帮助、反馈或功能建议，请联系 admin@acezerotrading.com。"
                                : "For help, feedback, or feature requests, contact admin@acezerotrading.com."
                        )
                    } label: {
                        Label(appState.tr("contact"), systemImage: "envelope.fill")
                    }

                    NavigationLink {
                        Text(appState.tr("contentNoteBody"))
                            .font(.body)
                            .foregroundStyle(Color.qgMuted)
                            .padding()
                            .navigationTitle(appState.tr("contentNote"))
                            .background(OneLineEnglishBackground())
                    } label: {
                        Label(appState.tr("contentNote"), systemImage: "text.book.closed")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        showResetConfirmation = true
                    } label: {
                        Label(appState.tr("reset"), systemImage: "trash")
                    }
                }

            }
            .navigationTitle(appState.tr("settings"))
            .scrollContentBackground(.hidden)
            .background(OneLineEnglishBackground())
            .tint(Color.qgAccent)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 72)
            }
            .confirmationDialog(appState.tr("reset"), isPresented: $showResetConfirmation, titleVisibility: .visible) {
                Button(appState.tr("reset"), role: .destructive) {
                    appState.resetProgress()
                }
                Button(appState.tr("cancel"), role: .cancel) {}
            }
        }
    }
}

private struct PolicyInfoView: View {
    let title: String
    let message: String

    var body: some View {
        Text(message)
            .font(.body)
            .foregroundStyle(Color.qgMuted)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle(title)
            .background(OneLineEnglishBackground())
    }
}
