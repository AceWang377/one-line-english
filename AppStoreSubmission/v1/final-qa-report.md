# Final QA Report

Date: 2026-05-28

## Build Verification

- Debug iOS Simulator build: passed on iPhone 17 Pro Max simulator.
- Release generic iOS build: passed with `CODE_SIGNING_ALLOWED=NO`.
- Debug physical iPhone build: passed on AceAirHotSpot.
- Release build generated App Store validation step during clean verification earlier: passed with `Validate ... -validate-for-store`.

## Device Verification

- Physical device app path was code-signed successfully.
- `OneLineEnglish.debug.dylib`: not present.
- `__preview.dylib`: not present.
- Installed to connected iPhone via `devicectl`.
- Launched on connected iPhone via `devicectl`: passed.

## Simulator Smoke Test

- App launched on iPhone 17 Pro Max simulator.
- Splash transitioned to Today screen.
- Today screen rendered without visible button overlap.
- Tapping `I know it` completed the daily goal.
- Completion screen showed `Today's line completed`.
- Review screen displayed learned quotes.

## Swipe Gesture Verification

- Fresh-install right swipe on the Today card: passed.
- Right swipe persisted progress as `lastAction: known`, `knownCount: 1`, `reviewState: none`.
- Fresh-install left swipe on the Today card: passed.
- Left swipe persisted progress as `lastAction: review`, `knownCount: 0`, `reviewState: needsReview`.
- Daily goal completed after one swiped line, matching the v1 requirement.

Evidence files:

- `/Users/wangzixuandemacbook/Desktop/One line English/QAArtifacts/final-release/05-before-right-swipe.jpg`
- `/Users/wangzixuandemacbook/Desktop/One line English/QAArtifacts/final-release/06-after-right-swipe.jpg`
- `/Users/wangzixuandemacbook/Desktop/One line English/QAArtifacts/final-release/07-right-swipe-progress.json`
- `/Users/wangzixuandemacbook/Desktop/One line English/QAArtifacts/final-release/08-after-left-swipe.jpg`
- `/Users/wangzixuandemacbook/Desktop/One line English/QAArtifacts/final-release/09-left-swipe-progress.json`

## Content Verification

- Quote card count: 240.
- Required top-level card fields: no missing fields.
- Source fields: no missing source status/note fields.
- Highlight markers: no missing quote-template highlight markers.
- Daily goal default: 1.

## Screenshot Verification

All current App Store screenshots are PNG files at 1320 x 2868 px:

- `01-onboarding.png`
- `02-today-card.png`
- `03-completed.png`
- `04-review.png`
- `05-settings-language.png`

## Submission Inputs

The app build is ready from a technical QA standpoint. Public URLs and contact email are prepared as:

- Privacy Policy URL: https://acewang377.github.io/one-line-english/privacy/
- Support URL: https://acewang377.github.io/one-line-english/support/
- Developer copyright owner: admin@acezerotrading.com
- App Review contact email: admin@acezerotrading.com
- GitHub Pages privacy and support pages returned HTTP 200 during final verification.
- App icon is declared as `AppIcon` in the built iPhone app and `AppIcon60x60@2x.png` is present in the app bundle.

Still required in App Store Connect:

- App Review contact name
- App Review contact phone
