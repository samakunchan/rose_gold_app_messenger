# CHANGELOG rose_gold_app_messenger

## 🚀 0.10.0 - 30/10/2026

### Added

- Added export data in json format or file.
- Added clear cache datas.

### Changed

- Update settings page and added the two latest features.

### Fixed

- Fix lint as usual.

---


## 🚀 0.9.0 - 29/10/2026

### Added

- Added dedicated Clean Architecture `profile` feature (data source, repository, use cases, view model, signals, DI).
- Added `ProfileAvatarPicker` supporting image selection, deletion, and preview.
- Added room avatar image picking and uploading in `RoomAvatarResult` and `EditRoomOwnerForm`.
- Added real-time profile synchronization via Supabase `onPostgresChanges` on `public.profiles`.
- Added `copyWith` methods to `UserProfileEntity`, `UserProfileViewModel`, `RoomMemberEntity`, and `RoomMemberViewModel`.
- Added unit tests for profile feature, avatar picker, and top user identifier.

### Changed

- Replaced avatar URL input with `ProfileAvatarPicker` in `EditProfileSettingScreen`.
- Unified avatar rendering across all screens using `MonogramUser` with `imageBytes` and `avatarUrl` support.
- Updated `RoomCardTile` to display the room avatar using `MonogramUser`.
- Updated `schema.sql` with idempotent `pg_publication_tables` checks for `supabase_realtime`.

### Fixed

- Fixed storage upload failure by mapping `image/jpg` MIME type to `image/jpeg`.
- Fixed `user_tag` NOT NULL violation on profile update by using targeted `.update().eq()` instead of naive `.upsert()`.
- Fixed non-instantaneous profile and avatar updates on other clients' screens via real-time change events.

---

## 🚀 0.8.0 - 29/10/2026

### Added

- Added End-to-End Encryption (E2EE) messaging architecture using Curve25519 (X25519) key exchange, ChaCha20-Poly1305 AEAD, and HKDF-SHA256 session key derivation.
- Added 12-word secret recovery passphrase system with PBKDF2-HMAC-SHA256 deterministic key derivation and user salt.
- Added user public key management (`public.user_public_keys`) with Supabase RLS and Realtime CDC synchronization.
- Added candidate keys multi-derivation mechanism supporting forward and backward secrecy for room members joining or leaving.
- Added Drift (SQLite) local storage for encrypted messaging cache with full-text search and offline capability (`AppDatabase`, `LocalMessagesTable`).
- Added hybrid media encryption for photos and videos: local symmetric encryption with ephemeral 256-bit key and upload to private bucket `chat-attachments-encrypted`.
- Added Zero-Knowledge attachment transmission: decryption key and nonce packaged inside the E2EE envelope.
- Added standalone `media` feature module (`lib/features/media/`) with `PickedMedia` entity, `MediaPickerDataSource`, and `MediaStorageDataSource`.
- Added public `avatars` Supabase Storage bucket with RLS policies for user profile and room avatars.
- Added use cases: `PickImageUseCase`, `PickVideoUseCase`, `UploadPublicAvatarUseCase`, and `DownloadAndDecryptMediaUseCase`.
- Added generic `AppMediaPickerBottomSheet` supporting avatar photo selection and chat photo/video attachments.
- Added UI chat components: `ChatScreen`, `ChatAppBar`, `ChatMessageBubble`, `ChatInputField`, `ChatMessagesList`, `ChatEmptyView`, `E2eeSecurityBanner`, `ChatSearchDelegate`, and `E2eePassphraseBottomSheet`.
- Added media display widgets: `ChatMediaAttachmentBubble` and `ChatFullScreenImageViewer` with interactive pinch-to-zoom.
- Added comprehensive unit test suites for local database caching, media crypto, and media picker.

### Changed

- Updated `ChatInputField` to use the shared `AppMediaPickerBottomSheet` from the new `media` feature.
- Upgraded Drift database schema to version 2 with migration for `attachmentJson` column.
- Scoped all sensitive keys in `FlutterSecureStorage` by user ID.

### Fixed

- Fixed `RealtimeSubscribeException` on Supabase Realtime client by registering `messages` in publication `supabase_realtime`.
- Fixed candidate decryption keys to allow senders to always read their pre-join and post-leave history without key loss.
- Fixed ListTile ink splash and background warning by replacing outer Container with a Material wrapper in the media picker bottom sheet.

---

## 🚀 0.7.0 - 27/10/2026

### Added

- Added change password screen into the settings screen.
- Added language selector to the settings screen.
- Added moderation feature to invitation card only for the moment.
- Added a page to manage blocked users.
- Added button to report user from invitation.
- Added custom feedback form
- Update feedback service and use a bucket to store images.
- Set up the feedback to main file.
- Added http package to send issues to Github issues.
- Fix feedback size form.
- Added screens.
- Added pages to Supabase and read by using edge functions.

### Changed

- Update material by added new package material_ui and cupertino_ui (Google Recommandation).
- Ran a command to update all files in once.

### Fixed

- Fix linters.
- Fix localization with the new material recommandation.
- Fix the saving for language selection and theme mode selection.

---

## 🚀 0.6.0 - 22/10/2026

### Added

- Added package for feedback. 
- Added Rooms data sources, models, and repositories.
- Added Rooms domain entities, repository contracts, and use cases.
- Added Rooms presentation layer: controllers, view models, and reactive signals.
- Added Rooms dependency injection containers.
- Added RoomsThemeExtension.
- Added logo.
- Build two pages: one for the main page and one specific page with more infos and for update the room info.

### Changed

- Deleted `HomeTest()`, `HomeTest1()`.
- Moved error ModalBottomSheet to `/core` folder.
- Rename method name.
- Added new errors messages and failure classes for rooms.
- Added user tag to make easy the search and invite users.

### Fixed

- Fix typo (not important).

---


## 🚀 0.5.0 - 13/10/2026

### Added

- Added User Presence data sources, models, and repositories.
- Added User Presence domain entities, repository contracts, and use cases.
- Added User Presence presentation layer: controllers, view models, and reactive signals.
- Added User presence dependency injection containers.

### Changed

- N/A

### Fixed

- Fix entitlement for macOS about flutter secure storage. It's specific macos.
- Fix auth redirection.
- Fix signals logs.

---


## 🚀 0.4.1 - 12/10/2026

### Added

- N/A

### Changed

- N/A

### Fixed

- Fix entitlement for macos about flutter secure storage. It's specific macos.
- Fix auth redirection.
- Fix signals logs.

---


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