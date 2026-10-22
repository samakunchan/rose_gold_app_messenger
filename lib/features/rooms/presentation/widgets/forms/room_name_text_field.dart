import 'package:flutter/material.dart';

class RoomNameTextField extends StatelessWidget {
  const new({required this.nameController, this.isLoading = false, this.onChanged, this.onClear, super.key});

  final TextEditingController nameController;
  final bool isLoading;
  final void Function(String)? onChanged;
  final void Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      enabled: !isLoading,
      textInputAction: .next,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Nom du salon',
        hintText: 'Nom de votre salon',
        prefixIcon: const Icon(Icons.title),
        suffixIcon: nameController.text.isNotEmpty
            ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: isLoading ? null : onClear)
            : null,
      ),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Veuillez saisir un nom';
        }
        return null;
      },
    );
  }
}
