import Foundation

struct LocalizedText: Codable, Hashable {
    let en: String
    let zhHans: String

    func value(isChinese: Bool) -> String {
        isChinese ? zhHans : en
    }
}

struct QuoteSource: Codable, Hashable {
    let status: String
    let note: String
}

struct QuoteCard: Codable, Identifiable, Hashable {
    let id: String
    let quoteTemplate: String
    let author: String
    let highlight: String
    let partOfSpeech: String
    let theme: String
    let level: String
    let meaning: LocalizedText
    let memoryHook: LocalizedText
    let expression: LocalizedText
    let example: LocalizedText
    let source: QuoteSource

    var quoteText: String {
        quoteTemplate.replacingOccurrences(of: "{{\(highlight)}}", with: highlight)
    }

    var quoteParts: (before: String, highlight: String, after: String) {
        let marker = "{{\(highlight)}}"
        guard let range = quoteTemplate.range(of: marker) else {
            return (quoteTemplate, highlight, "")
        }
        let before = String(quoteTemplate[..<range.lowerBound])
        let after = String(quoteTemplate[range.upperBound...])
        return (before, highlight, after)
    }
}

enum ReviewState: String, Codable {
    case none
    case needsReview
}

struct CardProgress: Codable, Hashable {
    var knownCount: Int = 0
    var reviewState: ReviewState = .none
    var isSaved: Bool = false
    var lastSeenDay: String?
    var lastReviewedAt: Date?
    var lastAction: String?
}

struct DailyState: Codable, Hashable {
    var day: String
    var deckCardIds: [String]
    var completedCardIds: [String]
    var dailyGoal: Int = 1
    var isCompleted: Bool = false

    static func empty(day: String) -> DailyState {
        DailyState(day: day, deckCardIds: [], completedCardIds: [])
    }
}

struct StreakState: Codable, Hashable {
    var currentStreak: Int = 0
    var longestStreak: Int = 0
    var lastCompletedDay: String?
}

enum AppLanguage: String, Codable, CaseIterable, Identifiable {
    case english
    case zhHans

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .english: return "English"
        case .zhHans: return "中文"
        }
    }
}

struct PersistedProgress: Codable {
    var progressByCard: [String: CardProgress] = [:]
    var dailyState: DailyState?
    var streakState: StreakState = StreakState()
    var onboardingCompleted: Bool = false
    var appLanguage: AppLanguage = .english

    init(
        progressByCard: [String: CardProgress] = [:],
        dailyState: DailyState? = nil,
        streakState: StreakState = StreakState(),
        onboardingCompleted: Bool = false,
        appLanguage: AppLanguage = .english
    ) {
        self.progressByCard = progressByCard
        self.dailyState = dailyState
        self.streakState = streakState
        self.onboardingCompleted = onboardingCompleted
        self.appLanguage = appLanguage
    }

    private enum CodingKeys: String, CodingKey {
        case progressByCard
        case dailyState
        case streakState
        case onboardingCompleted
        case appLanguage
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        progressByCard = try container.decodeIfPresent([String: CardProgress].self, forKey: .progressByCard) ?? [:]
        dailyState = try container.decodeIfPresent(DailyState.self, forKey: .dailyState)
        streakState = try container.decodeIfPresent(StreakState.self, forKey: .streakState) ?? StreakState()
        onboardingCompleted = try container.decodeIfPresent(Bool.self, forKey: .onboardingCompleted) ?? false
        appLanguage = try container.decodeIfPresent(AppLanguage.self, forKey: .appLanguage) ?? .english
    }
}
