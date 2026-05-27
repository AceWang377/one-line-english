# One Line English PRD v1.0
_Last updated: 2026-05-26_

## 0. Product Decision

**Recommended App Store name:** `One Line English`

**Why this name**
- Short, easy to remember, and under Apple's 30-character app-name limit.
- Communicates the core motion: users "glide" through quote cards.
- Stronger than generic names like "Daily Quotes" or "English Vocabulary".
- Preliminary web/App Store search did not find an exact App Store result for `One Line English` or `One Line English`. This is not a guarantee; final confirmation must be done by creating/reserving the app in App Store Connect.

**Backup names**
1. `WordGlide`
2. `WiseGlide`
3. `VocabGlide`

**Subtitle**
- EN: `Swipe quotes, learn words`
- zh-Hans: `滑动金句，学习英文`

**One-line positioning**
> One Line English is a swipe-based English quote card app that helps users learn one useful word from one memorable quote each day.

中文定位：
> One Line English 是一款滑动式英文金句卡片 App，让用户每天通过英文名言记住高价值英文单词和表达。

---

## 1. Background

The app should be a small but complete MVP focused on successful App Store submission first. It should not include backend, account login, paid subscription, AI, TTS, notifications, or community features in v1.0.

The first version must still feel complete and native:
- Swipe-first card experience.
- One highlighted English word per quote.
- Daily 10-card task.
- Streak system.
- Review queue for cards the user does not know.
- Favorites.
- Share image generation.
- English and Simplified Chinese UI localization.
- English quotes only. No Chinese translation of the quote text.

---

## 2. Product Goals

### 2.1 V1.0 Goals

1. **Successfully submit to the App Store.**
2. **Deliver a complete daily learning loop:**
   - Open app
   - Swipe 10 quote cards
   - Learn 10 highlighted words
   - Save favorite quotes
   - Review left-swiped cards
   - Complete daily goal
   - Maintain streak
3. **Make each card memorable:**
   - Beautiful quote presentation
   - One strong highlighted word
   - Minimal explanation
   - Simple swipe decision
4. **Avoid backend complexity:**
   - All content bundled locally.
   - Progress stored locally.
   - No user account.
   - No network dependency.
5. **Support two UI languages:**
   - English
   - Simplified Chinese

### 2.2 Non-goals for V1.0

Do not implement:
- TTS/audio pronunciation
- Push/local notifications
- AI explanations
- Login/account system
- Cloud sync
- User-generated quotes
- User comments/community
- Ads
- Subscription/IAP
- Widget
- Complex spaced repetition algorithm
- Chinese translations of quote text

---

## 3. Target Users

### 3.1 Primary User

Chinese-speaking English learners who:
- Like English quotes, self-growth, motivation, philosophy, or literary lines.
- Want to improve English vocabulary without heavy study pressure.
- Prefer short daily tasks.
- Enjoy beautiful cards and shareable content.

### 3.2 Secondary User

English-speaking users who:
- Like quote cards and vocabulary learning.
- Want to discover useful words in context.
- Prefer low-friction, swipe-based learning.

---

## 4. User Experience Principles

### Principle 1: One card teaches one thing

Each card only teaches **one** highlighted word or phrase. Do not overload the user with multiple vocabulary points.

### Principle 2: Quotes stay English-only

The quote itself should not show Chinese translation. The user sees the original English quote, author, highlighted word, and localized explanation of the highlighted word.

### Principle 3: Swipe equals learning

Swiping is not only navigation. It records the user's learning state:
- Right swipe = I know it
- Left swipe = Review later
- Up swipe or save button = Save quote

### Principle 4: Beautiful first, educational second

The user should first feel: "This card is beautiful and worth saving."  
Then the user notices the word explanation.

### Principle 5: Daily completion matters

The app should feel like a daily ritual, not a textbook. Streak should be based on completing today's 10 cards, not merely opening the app.

---

## 5. Core User Flows

## 5.1 First Launch Flow

1. User opens app.
2. App shows short onboarding with 3 pages:
   - Page 1: "Swipe through English quote cards."
   - Page 2: "Learn one useful word from each quote."
   - Page 3: "Complete 10 cards a day and build your streak."
3. User taps "Start".
4. User lands directly on Today deck.

**No login. No account. No onboarding survey.**

Chinese UI copy:
- Page 1: `滑动英文金句卡片`
- Page 2: `每张卡记住一个高价值单词`
- Page 3: `每天完成 10 张，建立学习连续性`
- CTA: `开始`

---

## 5.2 Today Daily Deck Flow

1. User opens Today tab.
2. User sees:
   - Header: Daily 10 / 今日 10 张
   - Progress: `3 / 10`
   - Streak badge: `🔥 3`
3. User sees a quote card.
4. User taps highlighted word area to reveal/hide details.
5. User swipes:
   - Right: mark as known.
   - Left: add to review.
   - Up or save button: save quote.
6. Progress increments after left/right swipe.
7. After 10 cards, show completion screen.

Completion screen:
- EN:
  - `Today's 10 completed`
  - `You learned 10 words today.`
  - `Current streak: 3 days`
  - `Review 4 words later`
- zh-Hans:
  - `今日 10 张已完成`
  - `今天你学习了 10 个英文词`
  - `当前连续学习：3 天`
  - `稍后复习 4 个词`

---

## 5.3 Review Flow

1. User taps Review tab.
2. If no review cards:
   - EN: `No review cards yet. Swipe left on a card to review it later.`
   - zh-Hans: `暂无复习卡片。左滑卡片后会加入复习。`
3. If review cards exist:
   - Header: `Review`
   - Count: `8 cards`
4. User reviews the same card UI.
5. Right swipe removes card from review.
6. Left swipe keeps card in review.

---

## 5.4 Saved Flow

1. User taps Saved tab.
2. Page has two segmented tabs:
   - Quotes
   - Words
3. Saved quotes show compact cards:
   - Quote
   - Author
   - Highlight word
   - Theme
4. Saved words show:
   - Word
   - Meaning
   - Source quote preview
5. User can open detail and share image.

V1.0 search can be omitted unless easy to implement. If implemented, search should search:
- Quote text
- Author
- Highlight word
- Theme

---

## 5.5 Share Image Flow

1. User taps Share on card or saved quote.
2. App generates a static image locally.
3. System share sheet opens.
4. Image includes:
   - English quote
   - Author
   - Highlight word
   - Short meaning
   - Small app watermark: `One Line English`

Recommended default size:
- 1080 × 1350 px portrait image.

No backend. No image upload.

---

## 6. Information Architecture

V1.0 should have 4 tabs:

1. **Today**
2. **Review**
3. **Saved**
4. **Settings**

### 6.1 Today

Purpose:
- Main daily swipe learning experience.

Key components:
- Header with progress and streak.
- Swipe card stack.
- Swipe hints.
- Save/share actions.
- Completion screen.

### 6.2 Review

Purpose:
- Let users revisit cards they left-swiped.

Key components:
- Review card count.
- Same swipe card UI.
- Empty state.

### 6.3 Saved

Purpose:
- Store favorite quote cards and highlighted words.

Key components:
- Segmented control: Quotes / Words.
- Saved list.
- Detail view.
- Share button.

### 6.4 Settings

Purpose:
- Required app information and simple preferences.

Must include:
- Language follows system setting.
- About
- Privacy Policy
- Contact Support
- Reset Progress
- Content disclaimer

No account settings.

---

## 7. Feature Requirements

## 7.1 Swipe Card Deck

### Functional Requirements

- Display one active card and optionally 1–2 cards behind it.
- Support drag gesture.
- Direction thresholds:
  - Right swipe: x offset > 120 or velocity strong enough.
  - Left swipe: x offset < -120 or velocity strong enough.
  - Up swipe: y offset < -140, optional for Save.
- Provide clear overlay feedback:
  - Right: `I know it`
  - Left: `Review later`
  - Up: `Saved`
- If user taps card body, toggle detail section.

### UX Requirements

- Swiping should feel smooth and responsive.
- Card stack should not jump after swipe.
- Add subtle haptic feedback on accepted swipe.
- Do not require users to press buttons, but provide fallback buttons for accessibility:
  - `Review`
  - `Know`
  - `Save`

### Accessibility Requirements

- All actions available by buttons.
- VoiceOver labels for main actions.
- Dynamic Type should not break card layout.

---

## 7.2 Highlighted Word

### Functional Requirements

Each card has exactly one highlighted word or phrase.

Card data should store quote using a template to make highlighting reliable:

```json
{
  "quoteTemplate": "Fortune favors the {{bold}}.",
  "highlight": "bold"
}
```

The app splits `quoteTemplate` into:
- before text
- highlighted text
- after text

Do not rely on fragile substring matching.

### Display Requirements

Default card front:
- Theme chip
- English quote with highlighted word visually emphasized
- Author
- Highlight word
- Short localized meaning

Expanded detail:
- Part of speech
- Localized meaning
- Memory hook
- Useful expression
- Example sentence

### Chinese UI rule

In Simplified Chinese UI:
- Quote remains English only.
- Author remains English.
- Highlight word remains English.
- Meaning/hook/labels are Chinese.

Example:
```text
“Fortune favors the bold.”
— Virgil

bold
勇敢的；大胆的

记忆点：bold = brave enough to act
常用表达：a bold decision
```

### English UI rule

In English UI:
```text
“Fortune favors the bold.”
— Virgil

bold
brave; willing to take risks

Memory hook: bold = brave enough to act
Expression: a bold decision
```

---

## 7.3 Daily 10

### Functional Requirements

- Daily target fixed at 10 cards in v1.0.
- Today progress is based on left/right swipes only.
- Saving a card does not count as completion.
- A completed card should not reappear in Today on the same day.
- Today deck should be deterministic for the local date, so reopening the app does not change the card order.

### Daily Deck Selection

Recommended simple algorithm:
1. Load all cards.
2. Exclude cards completed today.
3. Prefer cards not previously completed.
4. Fill up to 10 cards.
5. If user has completed all available cards, allow cycling through older cards ordered by least recent completion.

### Completion

When user reaches 10/10:
- Show completion screen.
- Update streak once.
- Store completed date.

---

## 7.4 Streak

### Definition

A streak increases only when the user completes the Daily 10.

### Streak Rules

Use local calendar day.

State:
```json
{
  "currentStreak": 3,
  "longestStreak": 5,
  "lastCompletedDay": "2026-05-26",
  "todayCompletionRecorded": true
}
```

Algorithm on Daily 10 completion:
1. Let `today = startOfDay(Date())`.
2. If `lastCompletedDay == today`, do not increment again.
3. If `lastCompletedDay == yesterday`, `currentStreak += 1`.
4. If `lastCompletedDay < yesterday` or nil, `currentStreak = 1`.
5. `longestStreak = max(longestStreak, currentStreak)`.
6. Set `lastCompletedDay = today`.

Important:
- Opening the app does not preserve streak.
- Reviewing cards does not increase streak.
- Saving cards does not increase streak.
- No notification in v1.0.

---

## 7.5 Review Queue

### Functional Requirements

- Left swipe from Today adds card to Review.
- Right swipe from Today marks card as known.
- Left swipe from Review keeps card in Review.
- Right swipe from Review removes card from Review.
- Review queue persists across app restarts.

### State

```json
{
  "cardId": "quote_001",
  "reviewState": "needsReview",
  "lastReviewedAt": "2026-05-26T12:00:00Z"
}
```

No FSRS/SM-2 spaced repetition in v1.0.

---

## 7.6 Saved Quotes and Words

### Functional Requirements

- User can save/unsave quote.
- Saved quote appears in Saved > Quotes.
- Highlight word from saved quote appears in Saved > Words.
- Saved status persists locally.
- Saved view can open detail.

### Optional

- Search saved items if implementation cost is low.
- Otherwise omit search in v1.0.

---

## 7.7 Share Image

### Functional Requirements

- User can generate image from any card.
- Image generated locally.
- Image includes:
  - Quote
  - Author
  - Highlight word
  - Meaning
  - App name watermark
- Use iOS share sheet.

### Implementation Recommendation

SwiftUI:
- Create `ShareCardView`.
- Use `ImageRenderer` to render `ShareCardView` to UIImage.
- Present `ShareLink` or `UIActivityViewController`.

### Design Requirements

Share image should be simple and premium:
- Quote large and readable.
- Highlight word emphasized.
- No Chinese translation of quote.
- Small watermark only.

---

## 7.8 Settings

### Required Items

- About One Line English
- Privacy Policy
- Contact Support
- Reset Progress
- Content Note

### Reset Progress

When tapped:
1. Show confirmation dialog.
2. If confirmed:
   - Clear daily progress.
   - Clear review queue.
   - Clear saved quotes.
   - Clear streak.
3. Reload Today deck.

### Content Note

Suggested copy:
- EN: `One Line English uses selected English quotes for vocabulary learning. Some attributions may vary across sources.`
- zh-Hans: `One Line English 使用精选英文金句帮助学习词汇。部分名言归属在不同来源中可能存在差异。`

---

## 8. Content Requirements

### 8.1 Quantity

V1.0 should ship with at least:
- 200 quote cards
- 200 highlighted words/phrases
- 8 themes
- 3 difficulty levels

Recommended:
- 240 cards: 30 cards × 8 themes

### 8.2 Themes

V1.0 themes:
1. Courage
2. Discipline
3. Wisdom
4. Time
5. Failure
6. Success
7. Creativity
8. Self-growth

### 8.3 Levels

Use simple levels:
- Easy
- Medium
- Advanced

Avoid CEFR in v1.0 unless content is reviewed carefully.

### 8.4 Content Safety

Use conservative sources:
- Public-domain authors.
- Ancient philosophers.
- Historical figures with public-domain texts.
- Very short phrases with clear citation history.
- Original learning examples written by the app creator.

Avoid:
- Lyrics
- Movie lines
- Modern books
- Long modern speeches
- Recent public figures unless the quote source is clearly licensed
- Scraping Goodreads, BrainyQuote, or similar databases

### 8.5 Quote Translation Rule

Do not provide Chinese translation of the quote in v1.0.

Allowed:
- Chinese UI labels.
- Chinese meaning of highlighted word.
- Chinese memory hook.
- Chinese explanation of expression.

Not allowed in v1.0:
- Full Chinese translation of quote.

---

## 9. Data Model

## 9.1 QuoteCard JSON

```json
{
  "id": "q_0001",
  "quoteTemplate": "Fortune favors the {{bold}}.",
  "author": "Virgil",
  "highlight": "bold",
  "partOfSpeech": "adjective",
  "theme": "Courage",
  "level": "Easy",
  "meaning": {
    "en": "brave; willing to take risks",
    "zhHans": "勇敢的；大胆的"
  },
  "memoryHook": {
    "en": "bold = brave enough to act",
    "zhHans": "bold 表示有勇气行动"
  },
  "expression": {
    "en": "a bold decision",
    "zhHans": "一个大胆的决定"
  },
  "example": {
    "en": "It was a bold decision.",
    "zhHans": "这是一个大胆的决定。"
  },
  "source": {
    "status": "public_domain",
    "note": "Traditional attribution"
  }
}
```

## 9.2 Progress State

```json
{
  "cardId": "q_0001",
  "knownCount": 1,
  "reviewState": "none",
  "isSaved": false,
  "lastSeenDay": "2026-05-26",
  "lastAction": "known"
}
```

## 9.3 Daily State

```json
{
  "day": "2026-05-26",
  "deckCardIds": ["q_001", "q_002"],
  "completedCardIds": ["q_001"],
  "dailyGoal": 10,
  "isCompleted": false
}
```

## 9.4 Streak State

```json
{
  "currentStreak": 0,
  "longestStreak": 0,
  "lastCompletedDay": null
}
```

---

## 10. Technical Requirements for Codex

### 10.1 Platform

- iOS app
- SwiftUI
- Minimum target: iOS 17 recommended
- No network dependency
- No backend
- No third-party SDK required
- No analytics in v1.0
- No ads
- No TTS/audio

### 10.2 Suggested Architecture

```text
OneLineEnglish/
  App/
    OneLineEnglishApp.swift
  Models/
    QuoteCard.swift
    CardProgress.swift
    DailyState.swift
    StreakState.swift
  Services/
    CardRepository.swift
    ProgressStore.swift
    DailyDeckService.swift
    StreakService.swift
    ShareImageService.swift
  ViewModels/
    TodayViewModel.swift
    ReviewViewModel.swift
    SavedViewModel.swift
    SettingsViewModel.swift
  Views/
    RootTabView.swift
    Today/
      TodayView.swift
      SwipeCardView.swift
      CompletionView.swift
    Review/
      ReviewView.swift
    Saved/
      SavedView.swift
      SavedDetailView.swift
    Settings/
      SettingsView.swift
    Components/
      QuoteCardContentView.swift
      ActionButton.swift
      EmptyStateView.swift
  Resources/
    quote_cards_v1.json
    Localizable.xcstrings
```

### 10.3 Persistence

Recommended:
- Store quote content in bundled JSON.
- Store progress in local file or UserDefaults with Codable.
- UserDefaults is acceptable for MVP if data size is small.
- Do not use CoreData/SwiftData unless needed.

Suggested local storage keys:
```text
progress_by_card
daily_state
streak_state
onboarding_completed
```

### 10.4 Swipe Implementation

Implement with:
- `DragGesture`
- `offset`
- `rotationEffect`
- overlay opacity based on drag direction
- threshold-based commit

Do not add third-party card libraries in v1.0 unless necessary.

### 10.5 Localization

Use:
- `Localizable.xcstrings`
- English default
- Simplified Chinese

Only UI strings and explanations are localized. Quote text remains English.

### 10.6 Share Image Rendering

Use:
- SwiftUI `ImageRenderer` for iOS 16+
- If issue occurs, fallback to `UIGraphicsImageRenderer`

---

## 11. UI Copy

## 11.1 Tab Names

English:
- Today
- Review
- Saved
- Settings

Chinese:
- 今日
- 复习
- 收藏
- 设置

## 11.2 Swipe Labels

English:
- I know it
- Review later
- Save

Chinese:
- 我会了
- 稍后复习
- 收藏

## 11.3 Empty States

Review empty:
- EN: `No review cards yet. Swipe left on a card to review it later.`
- zh-Hans: `暂无复习卡片。左滑卡片后会加入复习。`

Saved empty:
- EN: `No saved quotes yet. Save a card you love.`
- zh-Hans: `暂无收藏。遇到喜欢的卡片就收藏吧。`

Today completed:
- EN: `Today's 10 completed.`
- zh-Hans: `今日 10 张已完成。`

---

## 12. Visual Direction

### 12.1 Card Style

- Rounded card with soft shadow.
- Plenty of white space.
- Quote in large serif-like font.
- Highlight word emphasized with pill/highlight style.
- Author smaller and subtle.
- Theme chip at top.

### 12.2 Design Tone

Keywords:
- Calm
- Premium
- Thoughtful
- Minimal
- Educational, not academic
- Inspirational, not cheesy

### 12.3 Card Layout

```text
┌─────────────────────────────┐
│ Courage                     │
│                             │
│ “Fortune favors the bold.”  │
│                             │
│ — Virgil                    │
│                             │
│ bold                        │
│ brave; willing to take risks│
│                             │
│ a bold decision             │
└─────────────────────────────┘
```

Chinese UI:
```text
┌─────────────────────────────┐
│ Courage                     │
│                             │
│ “Fortune favors the bold.”  │
│                             │
│ — Virgil                    │
│                             │
│ bold                        │
│ 勇敢的；大胆的              │
│                             │
│ a bold decision             │
└─────────────────────────────┘
```

---

## 13. App Store Metadata Draft

### 13.1 App Name

`One Line English`

### 13.2 Subtitle

EN:
`Swipe quotes, learn words`

zh-Hans:
`滑动金句，学习英文`

### 13.3 Category

Primary:
- Education

Secondary:
- Lifestyle

### 13.4 Keywords

English:
```text
english,quotes,vocabulary,words,learn,daily,flashcards,wisdom,study
```

Chinese:
```text
英语,单词,名言,金句,学习,词汇,每日,卡片,英文
```

Do not use competitor names.

### 13.5 App Store Description Draft

English:
```text
One Line English helps you learn English through short, memorable quote cards.

Swipe through 10 English quote cards a day. Each card highlights one useful word or phrase, with a simple meaning, memory hook, and example expression. Swipe right when you know it, swipe left to review it later, and save your favorite quotes as beautiful shareable cards.

No account. No pressure. Just a small daily habit for better English.
```

Chinese:
```text
One Line English 是一款滑动式英文金句学习 App。

每天滑动 10 张英文金句卡片，每张卡只突出一个值得记住的英文单词或表达。会了就右滑，不熟就左滑加入复习，喜欢的金句可以收藏并生成分享图。

无需登录，无需复杂课程。每天几分钟，用英文金句建立轻量学习习惯。
```

### 13.6 Screenshot Plan

1. `Swipe English quote cards`
2. `Learn one word from each quote`
3. `Build your daily streak`
4. `Review words you don't know`
5. `Save and share beautiful cards`

Chinese localized screenshot copy:
1. `滑动英文金句卡片`
2. `每张卡记住一个重点词`
3. `完成每日 10 张，建立连续学习`
4. `左滑加入复习`
5. `收藏并分享你的金句卡`

---

## 14. App Review Readiness

V1.0 should be submitted with:
- Complete app, no placeholder screens.
- At least 200 real cards.
- Privacy Policy URL.
- Support URL or support email page.
- No network calls unless absolutely necessary.
- No tracking.
- No third-party analytics.
- No user-generated content.
- Screenshots captured from actual app UI.
- Accurate metadata: do not claim AI, pronunciation, advanced spaced repetition, or thousands of quotes if not included.

---

## 15. QA Checklist

### 15.1 Functional QA

- App launches without network.
- Onboarding appears only on first launch.
- Today deck shows 10 cards.
- Right swipe increments today progress.
- Left swipe increments today progress and adds to Review.
- Up swipe/save saves card but does not increment today progress.
- Completion screen appears at 10/10.
- Streak increments once per daily completion.
- Streak does not increment twice on same day.
- Review page shows left-swiped cards.
- Right swipe in Review removes card from Review.
- Saved page shows saved quote.
- Share image renders correctly.
- Reset Progress clears all local progress.
- App state persists after restart.

### 15.2 Localization QA

- English UI displays English strings.
- Chinese UI displays Chinese strings.
- Quote remains English in both languages.
- No quote Chinese translation appears.
- Chinese meanings fit card layout.
- Dynamic Type does not break layout.

### 15.3 Edge Cases

- No review cards.
- No saved cards.
- User completes all cards in content pool.
- User force quits during card swipe.
- User changes system date.
- User rotates device if orientation supported.
- Very long quote.
- Very long highlighted word.
- Missing author.

---

## 16. Acceptance Criteria

V1.0 can be considered ready when:

1. A user can complete the full loop:
   - Open app
   - Swipe 10 cards
   - Complete daily goal
   - See streak
   - Review left-swiped cards
   - Save and share a card
2. App contains at least 200 production-quality cards.
3. No backend, login, TTS, notifications, AI, ads, or subscriptions are present.
4. App supports English and Simplified Chinese UI.
5. Quote text remains English-only.
6. Share image works.
7. Privacy Policy and Support links exist.
8. App Store metadata does not overclaim functionality.

---

## 17. Codex Build Prompt

Use this prompt when asking Codex to implement the app:

```text
Build an iOS SwiftUI app named One Line English based on the attached PRD.

Core constraints:
- iOS 17+
- SwiftUI
- No backend
- No login
- No network
- No TTS/audio
- No notifications
- No ads
- No analytics
- No subscriptions/IAP in v1
- English and Simplified Chinese UI localization
- English quotes only; do not display Chinese translations of quote text
- Local JSON content
- Local progress persistence

Implement:
1. Four-tab structure: Today, Review, Saved, Settings.
2. First-launch onboarding with 3 pages.
3. Today swipe deck with 10 cards per day.
4. Quote card UI with one highlighted word.
5. Tap-to-expand card details.
6. Right swipe = known.
7. Left swipe = review later.
8. Save button and optional up swipe = save quote.
9. Daily progress and completion screen.
10. Streak system based on completing Daily 10.
11. Review queue for left-swiped cards.
12. Saved quotes/words page.
13. Share image generation using local rendering.
14. Reset progress in Settings.
15. Localizable strings in English and zh-Hans.
16. Bundled quote_cards_v1.json seed data.

Use MVVM-like organization with Models, Services, ViewModels, Views.
Avoid third-party libraries unless absolutely necessary.
```

---

## 18. Future Roadmap

### V1.1
- More content packs.
- Theme filter.
- Better completion animation.
- Optional daily reminder notification.

### V1.2
- Word-only review mode.
- Fill-in-the-blank quote quiz.
- Search Saved items.
- More share templates.

### V1.3
- One-time Pro unlock.
- Advanced vocabulary packs.
- Unlimited daily cards.

### V2.0
- AI explanations.
- Personalized examples.
- Cloud sync.
- Widget.
- More languages.