# AGENTS.md

This repository contains a SwiftUI iOS app concept for a calm sleep-and-morning audio companion. The product should feel quiet, warm, low-friction, intelligent, and not overly technical. Future agents should preserve that product direction while evolving the codebase incrementally.

## Product North Star

- The app helps users stop audio after they likely fall asleep and gently start audio after they likely wake.
- The MVP should validate the full night-to-morning loop with mocks before integrating real Watch, HealthKit, Spotify, widgets, or deep third-party audio control.
- The UI should feel like Apple-native software with a small amount of warm companion character and day/night atmosphere.
- Avoid turning the app into a technical sleep dashboard, a loud virtual pet, or a complex automation control panel.

## Coding Style

- Use Swift and SwiftUI idioms. Prefer clear, readable code over clever abstractions.
- Keep code beginner-friendly: simple types, explicit names, and small files.
- Prefer `struct` value models with `Codable`, `Identifiable`, and `Equatable` where useful.
- Use `enum` for finite states such as app modes, scene phases, audio source types, permission states, and sensitivity levels.
- Avoid force unwraps except in previews or clearly safe development-only mock data.
- Avoid global mutable state outside the app container, settings store, or intentionally scoped singletons such as a haptics helper.
- Keep comments short and useful. Add comments only when code intent is not obvious.
- Prefer composition over inheritance.
- Prefer dependency injection through initializers or an app container rather than hidden service creation inside views.

## SwiftUI Best Practices

- Views should describe UI only. Keep business logic in view models or services.
- Break large screens into small subviews once a view becomes hard to scan.
- Use SwiftUI previews for important visual states:
  - first launch
  - morning playback
  - daytime idle
  - night idle
  - night watching
  - sleep detected result
  - missing permission
- Use `NavigationStack` for stack navigation and `TabView` for top-level app sections.
- Prefer system controls and SF Symbols where they fit the interaction.
- Use semantic design tokens from the design system instead of one-off colors, spacing, and corner radii.
- Keep dark mode excellent. This app will often be used at night.
- Use `@State` only for local view-only interaction.
- Use view models for screen state and user actions.
- Use the settings store for persisted preferences.

## Architecture Rules

Use a lightweight MVVM + Service Layer architecture.

Expected layers:

- `App/`: app entry, app container, shared app state.
- `Navigation/`: tabs, routes, router.
- `DesignSystem/`: colors, typography, spacing, components, haptics, animation tokens.
- `Features/`: feature-specific views and view models.
- `Models/`: plain app models and enums.
- `Services/`: protocol-first service boundaries and mock/real implementations.

Rules:

- Feature views must not directly call HealthKit, WatchConnectivity, Spotify SDKs, MusicKit, or notification APIs.
- System integrations must live behind service protocols.
- MVP services should use mocks first:
  - `MockAudioManager`
  - `MockSleepDetectionService`
  - `MockHealthService`
  - `MockWatchConnectivityService`
  - `MockNotificationService`
- Real implementations should replace mocks through `AppContainer`, not by rewriting views.
- Do not introduce a heavy Clean Architecture structure unless real complexity proves it is needed.
- Avoid cross-feature imports where a shared model or design component would be cleaner.

## File Size Limits

These are soft limits. If a file exceeds them, consider splitting it.

- SwiftUI screen view: 250 lines.
- Small subview/component: 150 lines.
- View model: 250 lines.
- Service implementation: 300 lines.
- Model file: 150 lines.
- Design token file: 200 lines.
- Preview/mock data file: 250 lines.

If a file grows beyond these limits, split by responsibility, not by arbitrary line count.

## Naming Conventions

- Views end with `View`: `TodayView`, `SoundSettingsView`.
- View models end with `ViewModel`: `TodayViewModel`.
- Protocol services use capability names:
  - `AudioManaging`
  - `SleepDetecting`
  - `HealthAuthorizing`
  - `WatchConnectivityManaging`
  - `NotificationManaging`
- Mock services start with `Mock`: `MockAudioManager`.
- Real services should name the underlying integration: `HealthKitService`, `WatchConnectivityService`, `SpotifyAudioManager`.
- Models use nouns: `AudioSource`, `SleepSession`, `CompanionProfile`.
- State enums use clear domain names: `AppMode`, `PlaybackState`, `SleepDetectionState`.
- Design tokens use `App` prefix: `AppColors`, `AppSpacing`, `AppTypography`, `AppAnimation`.
- Avoid abbreviations unless they are standard Apple terms, such as `URL`, `ID`, or `API`.

## State Management Rules

Use three levels of state:

1. Local view state:
   - Use `@State` for transient UI details such as sheet visibility, selected temporary option, or pressed state.

2. Screen state:
   - Use a view model for screen-specific state and user actions.
   - A view model may call service protocols.
   - A view model should expose display-ready values where reasonable.

3. App and persisted state:
   - Use `AppState` for app-wide runtime state.
   - Use `SettingsStore` for user preferences.
   - Persist simple settings with `UserDefaults` behind `SettingsStore`.
   - Do not scatter many `@AppStorage` keys across views.

Important:

- Avoid duplicating the same source of truth across multiple view models.
- Prefer derived display values over manually synchronized duplicated strings.
- Keep session state explicit: idle, night starting, night watching, sleep detected, morning starting, morning playing, error.

## Animation Design Principles

Animations should be calm, slow, and low-stimulation.

Use:

- Gentle crossfades for state changes.
- Slow day/night background transitions.
- Subtle button press scaling.
- Minimal companion breathing animation.
- A short "good night" transition when the user taps "I'm going to sleep".
- Soft morning light transition when mock wake detection fires.

Avoid:

- Bouncy spring animations for sleep/night flows.
- Flashing, pulsing, or high-frequency motion.
- Spinners for sleep detection.
- Overly playful character animation.
- Bright transitions in night mode.

Respect reduced motion settings where practical.

## UI Consistency Rules

- The home screen is emotional and atmospheric.
- Settings screens are calm, native, and utilitarian.
- Records should feel like a gentle log, not a sleep score dashboard.
- Do not show raw heart rate, activity data, or algorithm details on the primary home experience.
- Use warm, short status text:
  - "正在安静守候"
  - "晚安"
  - "声音正在轻轻回来"
  - "昨晚声音已停下"
- Avoid technical status text in user-facing UI:
  - "HealthKit sample query running"
  - "WCSession activated"
  - "Sleep classifier confidence"
- Use design-system spacing, colors, typography, buttons, and cards.
- Keep the main action button easy to find and large enough to tap comfortably.
- Do not nest cards inside cards.
- Do not use large marketing hero layouts inside the actual app.
- Preserve excellent dark mode and low brightness for night states.

## Disabled Patterns

Do not implement these in MVP unless the user explicitly changes scope:

- Real HealthKit sleep/heart-rate detection.
- Real Apple Watch target and real `WCSession` communication.
- Spotify SDK integration.
- Apple Music or MusicKit deep playback.
- Precise third-party app content control.
- Background long-running sleep detection.
- Widgets and App Intents.
- Sleep score, trend analytics, or medical-style reporting.
- AI recommendations.
- Cloud sync.
- Companion customization systems beyond basic male/female style, tone, and animation intensity.

Do not use these code patterns:

- Views directly importing and calling HealthKit, WatchConnectivity, Spotify SDKs, or notification APIs.
- Hard-coded colors, spacing, and corner radii in feature views when design tokens exist.
- Massive view files with all subviews inline.
- Single all-purpose manager objects.
- Hidden side effects in model initializers.
- Force-unwrapped persisted data.
- Mock logic mixed into real service implementations.

## Future Agent Workflow

When working in this codebase:

1. Read this file first.
2. Identify the current implementation stage before editing.
3. Keep each change independently runnable in Xcode.
4. Prefer small, incremental patches over broad rewrites.
5. Preserve existing user-made changes.
6. Add or update previews for new visual states.
7. Keep system integrations behind service protocols.
8. Use mocks when building the MVP interaction loop.
9. Verify dark mode and important home states after UI changes.
10. Summarize what changed, what remains mocked, and what should be integrated later.

Recommended MVP implementation order:

1. Design system skeleton.
2. Tab navigation and app shell.
3. Static day/night home scene.
4. Onboarding and companion selection.
5. Persisted sound settings.
6. Mock night flow.
7. Mock morning flow.
8. Records and feedback.
9. Permission and error states.
10. Animation polish and preview coverage.

## Future Integration Notes

HealthKit:

- Add real HealthKit only through `HealthAuthorizing` / `HealthKitService`.
- Keep permission copy warm and non-technical.
- Do not expose raw metrics on the home screen by default.

Apple Watch:

- Add watch communication only through `WatchConnectivityManaging`.
- Share simple models between iOS and watchOS.
- Keep Watch UI minimal: start sleep, watching state, stop, morning controls.

Spotify:

- Add Spotify through a dedicated `SpotifyAudioManager` and auth service.
- Do not let Spotify SDK types leak into SwiftUI views.
- Treat Spotify as one possible audio provider, not the central architecture.

Widgets and App Intents:

- Add after the in-app night flow works.
- Widgets should trigger or open the "I'm going to sleep" flow with minimal friction.

## Quality Bar

A change is not ready if:

- The app does not run.
- Dark mode is visually harsh or unreadable.
- The home screen feels technical, busy, or noisy.
- A view directly owns future system integration logic.
- The same setting is stored in multiple places.
- A new feature requires a future rewrite of core navigation or state flow.

The app should always feel quiet, capable, and kind.
