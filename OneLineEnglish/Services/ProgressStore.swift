import Foundation

final class ProgressStore {
    private let key = "one_line_english_progress_v1"
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() -> PersistedProgress {
        guard let data = defaults.data(forKey: key) else {
            return PersistedProgress()
        }
        return (try? JSONDecoder().decode(PersistedProgress.self, from: data)) ?? PersistedProgress()
    }

    func save(_ progress: PersistedProgress) {
        guard let data = try? JSONEncoder().encode(progress) else {
            return
        }
        defaults.set(data, forKey: key)
    }

    func reset() {
        defaults.removeObject(forKey: key)
    }
}
