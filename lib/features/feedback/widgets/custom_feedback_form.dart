import 'dart:async';

import 'package:feedback/feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/feedback/signals/feed_back_store.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class CustomFeedbackForm extends StatefulWidget {
  const new({required this.onSubmit, required this.scrollController, super.key});

  final OnSubmit onSubmit;
  final ScrollController? scrollController;

  @override
  State<CustomFeedbackForm> createState() => _CustomFeedbackFormState();
}

class _CustomFeedbackFormState extends State<CustomFeedbackForm> {
  static const double _intermediateSheetSize = 0.40;

  final TextEditingController _textController = .new();
  String _selectedType = feedbackTypes.first;
  bool _isSubmitting = false;
  bool _minSizeLockEnabled = false;
  DraggableScrollableController? _sheetController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        return;
      }
      final DraggableScrollableController controller = BetterFeedback.of(context).sheetController;
      _sheetController = controller;
      controller.addListener(_clampToIntermediateSize);
      await _animateSheetTo(_intermediateSheetSize);
      if (mounted) {
        _minSizeLockEnabled = true;
      }
    });
  }

  void _clampToIntermediateSize() {
    final DraggableScrollableController? controller = _sheetController;
    if (!_minSizeLockEnabled || controller == null || !controller.isAttached) {
      return;
    }
    if (controller.size < _intermediateSheetSize) {
      controller.jumpTo(_intermediateSheetSize);
    }
  }

  String _labelForType(String type) {
    switch (type) {
      case 'bug':
        return 'Bug';
      case 'enhancement':
        return 'Amélioration';
      default:
        return 'Autre';
    }
  }

  Future<void> _animateSheetTo(double size) async {
    final DraggableScrollableController? controller = _sheetController;
    if (controller == null || !controller.isAttached) {
      return;
    }

    await controller.animateTo(size, duration: const Duration(milliseconds: 250), curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _sheetController?.removeListener(_clampToIntermediateSize);
    _textController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final String text = _textController.text.trim();
    if (text.isEmpty || _isSubmitting) {
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await widget.onSubmit(text, extras: <String, dynamic>{'type': _selectedType});
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              padding: EdgeInsets.fromLTRB(16, widget.scrollController != null ? 20 : 16, 16, 0),
              children: <Widget>[
                Padding(
                  padding: const .symmetric(horizontal: 160),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3), borderRadius: .circular(2)),
                  ),
                ),
                Padding(
                  padding: .only(bottom: AppSpacing.spaceSm.value),
                  child: Text('Type de retour', style: textTheme.titleMedium?.copyWith(fontWeight: .w600)),
                ),
                DropdownButtonFormField<String>(
                  initialValue: _selectedType,
                  items: feedbackTypes.map((String type) => DropdownMenuItem<String>(value: type, child: Text(_labelForType(type)))).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => _selectedType = value);
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const .symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(borderRadius: .circular(AppRadius.card.value)),
                  ),
                ),
                Padding(
                  padding: .symmetric(vertical: AppSpacing.spaceSm.value),
                  child: Text('Que souhaitez-vous nous signaler ?', style: textTheme.titleMedium?.copyWith(fontWeight: .w600)),
                ),
                Padding(
                  padding: .only(bottom: AppSpacing.spaceSm.value),
                  child: TextField(
                    controller: _textController,
                    maxLines: 4,
                    minLines: 2,
                    textInputAction: .newline,
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Décrivez le bug ou votre suggestion...',
                      border: OutlineInputBorder(borderRadius: .circular(AppRadius.card.value)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
              child: SizedBox(
                width: .infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: kLightPrimaryColor, foregroundColor: kLightOnPrimaryColor),
                  onPressed: _textController.text.trim().isEmpty || _isSubmitting ? null : _handleSubmit,
                  icon: _isSubmitting
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: kLightOnPrimaryColor))
                      : const Icon(Icons.send_outlined, size: 18),
                  label: Text(_isSubmitting ? 'Envoi en cours...' : 'Envoyer le retour'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
