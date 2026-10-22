import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class RoomDescriptionTextField extends StatelessWidget {
  const new({required this.descriptionController, this.isLoading = false, this.onChanged, this.onClear, this.onFieldSubmitted, super.key});

  final TextEditingController descriptionController;
  final bool isLoading;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descriptionController,
      enabled: !isLoading,
      maxLines: 3,
      textInputAction: .done,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: 'Description (optionnelle)',
        hintText: 'Description du salon',
        // prefixIcon: const Icon(Icons.description_outlined),
        suffixIcon: descriptionController.text.isNotEmpty
            ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: isLoading ? null : onClear)
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(AppRadius.defaultValue.value),
          borderSide: const BorderSide(color: kGoldInputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(AppRadius.defaultValue.value),
          borderSide: const BorderSide(color: kChampagneGoldColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: .circular(AppRadius.defaultValue.value),
          borderSide: const BorderSide(color: kLightErrorColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: .circular(AppRadius.defaultValue.value),
          borderSide: const BorderSide(color: kLightErrorColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: .circular(AppRadius.defaultValue.value),
          borderSide: BorderSide(color: kHairlineDividerColor.withValues(alpha: 0.5)),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
