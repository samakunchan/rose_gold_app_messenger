import 'package:flutter/material.dart';

class RoomAvatarTextField extends StatelessWidget {
  const new({required this.avatarUrlController, this.isLoading = false, this.onChanged, this.onClear, super.key});

  final TextEditingController avatarUrlController;
  final bool isLoading;
  final void Function(String)? onChanged;
  final void Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: avatarUrlController,
      enabled: !isLoading,
      textInputAction: .next,
      keyboardType: .url,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'URL de l’avatar (optionnelle)',
        hintText: 'https://exemple.com/image.png',
        prefixIcon: const Icon(Icons.image_outlined),
        suffixIcon: avatarUrlController.text.isNotEmpty
            ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: isLoading ? null : onClear)
            : null,
      ),
    );
  }
}
