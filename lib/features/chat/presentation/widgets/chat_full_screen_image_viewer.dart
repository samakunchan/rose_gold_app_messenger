import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

class ChatFullScreenImageViewer extends StatelessWidget {
  const new({required this.imageBytes, required this.title, super.key});

  final Uint8List imageBytes;
  final String title;

  static void show(BuildContext context, {required Uint8List imageBytes, required String title}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChatFullScreenImageViewer(imageBytes: imageBytes, title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.7),
        foregroundColor: Colors.white,
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          maxScale: 4,
          child: Image.memory(imageBytes, fit: .contain),
        ),
      ),
    );
  }
}
