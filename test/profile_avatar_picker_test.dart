import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/forms/profile_avatar_picker.dart';

void main() {
  testWidgets('MonogramUser displays memory image when imageBytes provided', (WidgetTester tester) async {
    final Uint8List testBytes = Uint8List.fromList(<int>[
      0x89,
      0x50,
      0x4E,
      0x47,
      0x0D,
      0x0A,
      0x1A,
      0x0A,
      0x00,
      0x00,
      0x00,
      0x0D,
      0x49,
      0x48,
      0x44,
      0x52,
      0x00,
      0x00,
      0x00,
      0x01,
      0x00,
      0x00,
      0x00,
      0x01,
      0x08,
      0x06,
      0x00,
      0x00,
      0x00,
      0x1F,
      0x15,
      0xC4,
      0x89,
      0x00,
      0x00,
      0x00,
      0x0A,
      0x49,
      0x44,
      0x41,
      0x54,
      0x78,
      0x9C,
      0x63,
      0x00,
      0x01,
      0x00,
      0x00,
      0x05,
      0x00,
      0x01,
      0x0D,
      0x0A,
      0x2D,
      0xB4,
      0x00,
      0x00,
      0x00,
      0x00,
      0x49,
      0x45,
      0x4E,
      0x44,
      0xAE,
      0x42,
      0x60,
      0x82,
    ]);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MonogramUser(username: 'Alice', imageBytes: testBytes, size: 60),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('ProfileAvatarPicker renders fallback initials and "Ajouter une photo" when empty', (WidgetTester tester) async {
    bool pickTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileAvatarPicker(
            username: 'John Doe',
            onPick: () {
              pickTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('PHOTO DE PROFIL'), findsOneWidget);
    expect(find.text('JD'), findsOneWidget);
    expect(find.text('Ajouter une photo'), findsOneWidget);
    expect(find.text('Supprimer'), findsNothing);

    await tester.tap(find.text('Ajouter une photo'));
    expect(pickTapped, isTrue);
  });

  testWidgets('ProfileAvatarPicker renders "Changer" and "Supprimer" when avatar exists', (WidgetTester tester) async {
    bool removeTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileAvatarPicker(
            username: 'John Doe',
            avatarUrl: 'https://example.com/avatar.jpg',
            onPick: () {},
            onRemove: () {
              removeTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Changer'), findsOneWidget);
    expect(find.text('Supprimer'), findsOneWidget);

    await tester.tap(find.text('Supprimer'));
    expect(removeTapped, isTrue);
  });

  testWidgets('ProfileAvatarPicker renders "Changer" and "Supprimer" when pickedMedia exists', (WidgetTester tester) async {
    final PickedMedia media = PickedMedia(bytes: Uint8List.fromList(<int>[1, 2, 3]), fileName: 'photo.jpg', fileSize: 3, mimeType: 'image/jpeg');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileAvatarPicker(username: 'John Doe', pickedMedia: media, onPick: () {}, onRemove: () {}),
        ),
      ),
    );

    expect(find.text('Changer'), findsOneWidget);
    expect(find.text('Supprimer'), findsOneWidget);
  });

  testWidgets('ProfileAvatarPicker shows progress indicator when uploading and disables buttons', (WidgetTester tester) async {
    bool pickTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileAvatarPicker(
            username: 'John Doe',
            isUploading: true,
            onPick: () {
              pickTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.text('Ajouter une photo'));
    expect(pickTapped, isFalse);
  });
}
