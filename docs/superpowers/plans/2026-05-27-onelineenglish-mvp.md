# OneLineEnglish MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the OneLineEnglish v1.0 native SwiftUI MVP from the PRD and bundled public-domain quote candidates.

**Architecture:** A single iOS 17 SwiftUI app with local JSON content, UserDefaults persistence, deterministic daily decks, and small services for daily progress, streaks, review queue, saved cards, and share rendering. The UI uses a four-tab shell with onboarding, a swipe-first Today deck, Review, Saved, and Settings.

**Tech Stack:** SwiftUI, Observation-compatible `ObservableObject`, Codable, UserDefaults, bundled JSON resources, Xcode project generated locally.

---

### Task 1: Project Scaffold

**Files:**
- Create: `OneLineEnglish.xcodeproj`
- Create: `OneLineEnglish/App/OneLineEnglishApp.swift`
- Create: `OneLineEnglish/Resources/Info.plist`
- Create: `OneLineEnglish/Resources/Assets.xcassets`

- [ ] Generate a minimal iOS SwiftUI Xcode project with bundle id `com.onelineenglish.onelineenglish`.
- [ ] Add app entry point, asset catalog, and Info.plist.
- [ ] Verify the app target is visible to `xcodebuild -list`.

### Task 2: Content and State Core

**Files:**
- Create: `OneLineEnglish/Models/QuoteCard.swift`
- Create: `OneLineEnglish/Models/AppState.swift`
- Create: `OneLineEnglish/Services/CardRepository.swift`
- Create: `OneLineEnglish/Services/ProgressStore.swift`
- Create: `OneLineEnglish/Services/DailyDeckService.swift`
- Create: `OneLineEnglish/Services/ShareImageService.swift`
- Create: `OneLineEnglish/Resources/quote_cards_v1.json`

- [ ] Transform at least 240 source candidates into the PRD data shape.
- [ ] Implement deterministic daily deck selection, review queue, saved cards, and streak update rules.
- [ ] Persist progress locally with UserDefaults.

### Task 3: SwiftUI MVP Screens

**Files:**
- Create: `OneLineEnglish/Views/RootTabView.swift`
- Create: `OneLineEnglish/Views/OnboardingView.swift`
- Create: `OneLineEnglish/Views/Today/TodayView.swift`
- Create: `OneLineEnglish/Views/Today/SwipeCardView.swift`
- Create: `OneLineEnglish/Views/Today/CompletionView.swift`
- Create: `OneLineEnglish/Views/Review/ReviewView.swift`
- Create: `OneLineEnglish/Views/Saved/SavedView.swift`
- Create: `OneLineEnglish/Views/Settings/SettingsView.swift`
- Create: `OneLineEnglish/Views/Components/QuoteCardContentView.swift`

- [ ] Add localized English/Simplified Chinese UI strings in code using current locale.
- [ ] Implement swipe gestures and accessible fallback buttons.
- [ ] Implement onboarding, Today completion, Review empty state, Saved segmented views, Settings reset, and share sheet.

### Task 4: Verification

- [ ] Build with `xcodebuild`.
- [ ] Run on an iOS Simulator if available.
- [ ] Fix compiler/runtime issues found during verification.
