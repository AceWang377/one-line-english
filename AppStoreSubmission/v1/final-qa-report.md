# Final QA Report

Date: 2026-05-28

## Build Verification

- Debug iOS Simulator build: passed.
- Release generic iOS build: passed.
- Debug physical iPhone build: passed.
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

Still required in App Store Connect:

- App Review contact name
- App Review contact phone
