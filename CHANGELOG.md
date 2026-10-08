# CHANGELOG rose_gold_app_messenger

## 🚀 0.4.0 - 08/10/2026 [SUPABASE AUTHENTICATION]

Because it was my first time with **Supabase**, the commits are massive. But I think we have all here.

### Added

- Added deep link configuration for Android, iOS, and macOS.
- Added dependencies for data modeling, functional error handling, and utilities (`freezed`, `json_annotation`, `equatable`, `dart_either`, `timeago`).
- Added generic UI widgets, splash screen components, and widget exports.
- Added core error handling and failure classes.
- Added secure local storage helper.
- Added Supabase authentication data sources, models, and repositories.
- Added Supabase authentication domain entities, repository contracts, and use cases.
- Added Supabase authentication presentation layer: controllers, view models, and reactive signals.
- Added Supabase authentication UI widgets and screens (authentication, change password, reset password).
- Added core and authentication dependency injection containers.
- Added `MainApp` root widget.
- Added `HomeTest` screen for development testing.

### Changed

- Updated linter configuration in `analysis_options.yaml`.
- Updated `README.md` documentation.
- Updated `main.dart` with environment variables, dependency injection, and Supabase initialization.

### Fixed

- Added default fallback class for localization in context extension.

---


## 🚀 0.3.0 - 27/09/2026

### Added

- Added `flutter_localizations` package.
- Added l10n.yaml file to generate localizations files.
- Added arb files for "EN" and "FR".
- Added arb context and string extensions.
- Added devtools file.

### Changed

- Initiate localization to the main file.
- Organize code generation packages.

### Fixed

- N/A

---


## 🚀 0.2.0 - 26/09/2026

### Added

- Added themes files.

### Changed

- N/A

### Fixed

- Added back flutter sdk. I removed it without knowing.

---


## 🚀 0.1.0 - 26/09/2026

### Added

- Added linter configuration for the project.
- Added packages that I think it's good for the start.
- Added some files to gitignore.

### Changed

- N/A

### Fixed

- N/A