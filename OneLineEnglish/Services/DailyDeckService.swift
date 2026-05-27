import Foundation

struct DailyDeckService {
    let dailyGoal = 1

    func todayString(now: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: now)
    }

    func yesterdayString(now: Date = Date()) -> String {
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: now)) ?? now
        return todayString(now: yesterday)
    }

    func deck(for cards: [QuoteCard], progress: [String: CardProgress], stored: DailyState?, today: String) -> DailyState {
        if let stored, stored.day == today, stored.dailyGoal == dailyGoal, !stored.deckCardIds.isEmpty {
            return stored
        }

        let freshCards = cards
            .filter { progress[$0.id]?.lastSeenDay == nil }

        let olderCards = cards
            .filter { progress[$0.id]?.lastSeenDay != nil }
            .sorted {
                let lhs = progress[$0.id]?.lastSeenDay ?? ""
                let rhs = progress[$1.id]?.lastSeenDay ?? ""
                return lhs == rhs ? $0.id < $1.id : lhs < rhs
            }

        let selected = Array((freshCards + olderCards).prefix(dailyGoal)).map(\.id)
        return DailyState(day: today, deckCardIds: selected, completedCardIds: [], dailyGoal: dailyGoal)
    }

    func recordCompletion(streak: StreakState, today: String, yesterday: String) -> StreakState {
        if streak.lastCompletedDay == today {
            return streak
        }

        var next = streak
        if streak.lastCompletedDay == yesterday {
            next.currentStreak += 1
        } else {
            next.currentStreak = 1
        }
        next.longestStreak = max(next.longestStreak, next.currentStreak)
        next.lastCompletedDay = today
        return next
    }
}
