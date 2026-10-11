## LateStart

> **Archived snapshot (2024–2025).** This repo is a cleaned, static snapshot of the LateStart project. School calendar/alarm data tables are frozen as of the 2025–26 school year, and the app is not under active development.

## Project Overview

**LateStart** is a mobile app designed to help schools and students manage cycle-day calendars and alarms.

It was originally built for personal use, then expanded to teachers, classmates, and family, and later adapted for school-wide use.

**This repo contains:**

- The v3 (latest) codebase, cleaned and organized for review

---

## Tech Stack

- **Framework:** Flutter

- **Backend:** Firebase

- **Database:** Isar / SQLite

- **Authentication:** Google Auth

- **Alarms & Notifications:** alarm package

- **State Management:** GetX

---

## File Structure

```
LateStart/

└── lib/

    ├── base/                       # Base classes and shared utilities

    ├── datas/                      # Data management and core data models

    │   ├── firebase_options.dart   # Firebase configuration (keys redacted)

    │   ├── data_* files            # Alarm, calendar, and school data logic

    ├── main.dart                   # App entry point (release version)

    ├── main2.dart                  # Alternate build or testing entry

    ├── models/                     # Data model definitions

    ├── pages/                      # UI pages (home, settings, calendar, etc.)

    ├── providers/                  # Database and storage providers

    │   ├── get_storage_provider.dart

    │   ├── isar_provider.dart

    │   └── secure_storage_provider.dart

    ├── services/                   # App services and logic layers

    ├── temp/                       # Temporary modules or experimental files

    ├── utils/                      # Helper utilities and constants

    └── widgets/                    # Reusable Flutter widgets and UI components

```

---

## ‍Contribution

**Angela Yuan (student):**

- Designed the entire user interface (initial layouts prototyped in PowerPoint)

- Implemented front-end screens and interaction logic in Flutter

- Built the breakout-day configurator and cycle-day calculation logic

- Created and tested UI flows for alarm editing, school selection, and calendar views

- Conducted end-to-end testing across multiple Android and iOS devices

**Mentor:**

- Designed overall architecture, database structure, and system integrations

- Integrated backend frameworks (Firebase, SQL, Google Auth)

- Integrated the open-source alarm package and notification logic

- Assisted with advanced debugging and framework configuration

- Reviewed code and verified build stability

---

## How to Run

1. Install **Flutter 3.24.5** (channel stable).

2. Ensure your environment meets the following requirements:

   - **macOS Sequoia 15.7.1** with **Xcode 26.0.1 (17A400)**, supporting Swift 6.0+ and Firebase 11.0+.

   - **Android Studio** (or command-line tools) with Android SDK and JDK 17+ installed.

3. Clone the project.

4. Add your own Firebase configuration files (`android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`) and fill in the API keys in `lib/firebase_options.dart` — placeholders are used in this repo.

5. Run `flutter pub get` to install dependencies.

6. Launch an emulator (Android or iOS via VS Code / Xcode) or connect a physical device.

7. Run `flutter run` to build and launch the app.

---

## Dependencies

The app uses several open-source Flutter packages. Full versions are listed in `pubspec.yaml`.

- `get: ^4.6.6` – State management and navigation

- `intl: ^0.18.1` – Date/time formatting and localization

- `alarm: ^3.1.2` – Scheduling and triggering alarms/notifications

- `flutter_local_notifications: ^17.2.1+2` – Local notification handling

- `flutter_native_timezone: ^2.0.0` – Timezone detection and conversion

- `google_sign_in: ^6.2.1` – User authentication with Google

- `firebase_core: ^3.2.0` – Firebase initialization

- `firebase_auth: ^5.1.2` – Firebase authentication services

- `isar_flutter_libs: ^4.0.0` – Isar database Flutter bindings

- `path_provider: ^2.1.4` – File path access across platforms

- `timezone: ^0.9.4` – Timezone-aware scheduling

- `uuid: ^4.5.1` – Unique ID generation

---

## Notes

- All third-party packages are open-source.

- Sensitive keys (Firebase API keys, etc.) have been removed or replaced with placeholders; app signing keys and platform config files are not included.

- School data tables are frozen as of the 2025–26 school year (archived snapshot).
