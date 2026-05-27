import Foundation
import SwiftUI

enum AppTab: Hashable {
    case today
    case review
    case settings
}

enum DeckContext {
    case today
    case review
}

final class AppState: ObservableObject {
    @Published var cards: [QuoteCard] = []
    @Published var progressByCard: [String: CardProgress] = [:]
    @Published var dailyState: DailyState
    @Published var streakState = StreakState()
    @Published var onboardingCompleted = false
    @Published var appLanguage: AppLanguage = .english
    @Published var selectedTab: AppTab = .today
    @Published var selectedReviewCard: QuoteCard?
    @Published var shareCard: QuoteCard?

    let deckService = DailyDeckService()
    private let repository = CardRepository()
    private let store = ProgressStore()

    init() {
        let today = DailyDeckService().todayString()
        dailyState = .empty(day: today)
        load()
    }

    var isChinese: Bool {
        appLanguage == .zhHans
    }

    var dailyProgressText: String {
        "\(dailyState.completedCardIds.count) / \(dailyState.dailyGoal)"
    }

    var todayCards: [QuoteCard] {
        dailyState.deckCardIds.compactMap(cardById)
    }

    var currentTodayCard: QuoteCard? {
        let completed = Set(dailyState.completedCardIds)
        return todayCards.first { !completed.contains($0.id) }
    }

    var reviewCards: [QuoteCard] {
        cards.filter { progressByCard[$0.id]?.reviewState == .needsReview }
    }

    var learnedCards: [QuoteCard] {
        cards.filter { card in
            let progress = progressByCard[card.id]
            return progress?.lastSeenDay != nil || (progress?.knownCount ?? 0) > 0
        }
    }

    var learnedWords: [QuoteCard] {
        var seen = Set<String>()
        return learnedCards.filter { card in
            let key = card.highlight.lowercased()
            if seen.contains(key) { return false }
            seen.insert(key)
            return true
        }
    }

    func load() {
        cards = (try? repository.loadCards()) ?? []
        let persisted = store.load()
        progressByCard = persisted.progressByCard
        streakState = persisted.streakState
        onboardingCompleted = persisted.onboardingCompleted
        appLanguage = persisted.appLanguage
        refreshDailyDeck()
    }

    func finishOnboarding() {
        onboardingCompleted = true
        persist()
    }

    func refreshDailyDeck() {
        let today = deckService.todayString()
        dailyState = deckService.deck(for: cards, progress: progressByCard, stored: store.load().dailyState, today: today)
        persist()
    }

    func cardById(_ id: String) -> QuoteCard? {
        cards.first { $0.id == id }
    }

    func setLanguage(_ language: AppLanguage) {
        appLanguage = language
        persist()
    }

    func handle(_ direction: SwipeDirection, card: QuoteCard, context: DeckContext) {
        switch direction {
        case .left:
            markForReview(card, context: context)
        case .right:
            markKnown(card, context: context)
        case .up:
            shareCard = card
        }
    }

    func markKnown(_ card: QuoteCard, context: DeckContext) {
        var progress = progressByCard[card.id, default: CardProgress()]
        progress.knownCount += 1
        progress.reviewState = .none
        progress.lastReviewedAt = Date()
        progress.lastAction = "known"

        if context == .today {
            progress.lastSeenDay = dailyState.day
            appendDailyCompletion(card.id)
        }

        progressByCard[card.id] = progress
        persist()
    }

    func markForReview(_ card: QuoteCard, context: DeckContext) {
        var progress = progressByCard[card.id, default: CardProgress()]
        progress.reviewState = .needsReview
        progress.lastReviewedAt = Date()
        progress.lastAction = "review"

        if context == .today {
            progress.lastSeenDay = dailyState.day
            appendDailyCompletion(card.id)
        }

        progressByCard[card.id] = progress
        persist()
    }

    func resetProgress() {
        store.reset()
        progressByCard = [:]
        streakState = StreakState()
        onboardingCompleted = false
        selectedReviewCard = nil
        dailyState = .empty(day: deckService.todayString())
        refreshDailyDeck()
    }

    func tr(_ key: String) -> String {
        let zh = isChinese
        switch key {
        case "today": return zh ? "今日" : "Today"
        case "review": return zh ? "复习" : "Review"
        case "settings": return zh ? "设置" : "Settings"
        case "daily10": return zh ? "每日一句" : "Daily Line"
        case "know": return zh ? "我会了" : "I know it"
        case "reviewLater": return zh ? "稍后复习" : "Review later"
        case "save": return zh ? "分享" : "Share"
        case "share": return zh ? "分享" : "Share"
        case "quotes": return zh ? "金句" : "Quotes"
        case "words": return zh ? "单词" : "Words"
        case "emptyReview": return zh ? "还没有学习记录。完成今天的一句后会出现在这里。" : "No learned lines yet. Finish today's line to build your review list."
        case "completedTitle": return zh ? "今日一句已完成" : "Today's line completed"
        case "completedBody": return zh ? "今天你学习了 1 个英文关键词" : "You learned 1 English keyword today."
        case "currentStreak": return zh ? "当前连续学习" : "Current streak"
        case "reviewLaterCount": return zh ? "学习记录" : "Learned lines"
        case "start": return zh ? "开始" : "Start"
        case "reset": return zh ? "重置进度" : "Reset Progress"
        case "about": return zh ? "关于 One Line English" : "About One Line English"
        case "privacy": return zh ? "隐私政策" : "Privacy Policy"
        case "contact": return zh ? "联系支持" : "Contact Support"
        case "done": return zh ? "完成" : "Done"
        case "cancel": return zh ? "取消" : "Cancel"
        case "contentNote": return zh ? "内容说明" : "Content Note"
        case "contentNoteBody": return zh ? "One Line English 使用精选英文名句帮助学习词汇。部分名言归属在不同来源中可能存在差异。" : "One Line English uses selected English quotes for vocabulary learning. Some attributions may vary across sources."
        case "language": return zh ? "应用语言" : "App Language"
        case "learningEnglishOnly": return zh ? "学习内容保持英文，仅切换界面语言" : "Learning content stays English; only app UI changes"
        default: return key
        }
    }

    private func appendDailyCompletion(_ cardId: String) {
        guard !dailyState.completedCardIds.contains(cardId) else {
            return
        }
        dailyState.completedCardIds.append(cardId)
        if dailyState.completedCardIds.count >= dailyState.dailyGoal {
            dailyState.isCompleted = true
            streakState = deckService.recordCompletion(
                streak: streakState,
                today: deckService.todayString(),
                yesterday: deckService.yesterdayString()
            )
        }
    }

    private func persist() {
        store.save(PersistedProgress(
            progressByCard: progressByCard,
            dailyState: dailyState,
            streakState: streakState,
            onboardingCompleted: onboardingCompleted,
            appLanguage: appLanguage
        ))
    }
}
