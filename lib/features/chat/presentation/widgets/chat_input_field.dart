import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/utils/emoji_catalog.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_emoji_autocomplete_popup.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_input_emoji_picker_bottom_sheet.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/media/presentation/widgets/app_media_picker_bottom_sheet.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ChatInputField extends StatefulWidget {
  const new({
    required this.roomId,
    this.peerPublicKeyBase64,
    this.onMessageSent,
    super.key,
  });

  final String roomId;
  final String? peerPublicKeyBase64;
  final VoidCallback? onMessageSent;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  late final FocusNode _focusNode = FocusNode(onKeyEvent: _handleKeyEvent);
  List<EmojiData> _autocompleteSuggestions = <EmojiData>[];
  int _colonStartIndex = -1;

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent && (event.logicalKey == .enter || event.logicalKey == .numpadEnter) && !HardwareKeyboard.instance.isShiftPressed) {
      if (_autocompleteSuggestions.isNotEmpty) {
        _applyEmojiFromAutocomplete(_autocompleteSuggestions.first);
        return .handled;
      }
      unawaited(_handleSend());
      return .handled;
    }
    return .ignored;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String text) {
    kGetIt<ChatSignals>().onInputTextChanged(text);
    _checkAndAutoReplaceEmoticons(text);
    _checkForColonAutocomplete(_controller.text);
  }

  void _checkAndAutoReplaceEmoticons(String text) {
    // Si l'utilisateur vient de taper un espace ou un saut de ligne, on convertit les émoticônes précédents
    final String converted = EmojiData.convertEmoticons(text);
    if (converted != text) {
      final int diff = converted.length - text.length;
      final int oldCursor = _controller.selection.baseOffset;
      final int newCursor = (oldCursor + diff).clamp(0, converted.length);

      _controller.value = TextEditingValue(
        text: converted,
        selection: TextSelection.collapsed(offset: newCursor),
      );
    }
  }

  void _checkForColonAutocomplete(String text) {
    final TextSelection selection = _controller.selection;
    if (!selection.isValid || selection.start != selection.end) {
      if (_autocompleteSuggestions.isNotEmpty) {
        setState(() {
          _autocompleteSuggestions = <EmojiData>[];
        });
      }
      return;
    }

    final int cursor = selection.baseOffset;
    final String textBeforeCursor = text.substring(0, cursor);
    final int lastColon = textBeforeCursor.lastIndexOf(':');

    if (lastColon != -1) {
      final String candidate = textBeforeCursor.substring(lastColon + 1);
      // Ne déclenche l'autocomplétion que si le mot après ':' ne contient pas d'espace
      if (!candidate.contains(' ') && candidate.length <= 15) {
        final List<EmojiData> matches = EmojiData.search(candidate);
        setState(() {
          _colonStartIndex = lastColon;
          _autocompleteSuggestions = matches.take(6).toList();
        });
        return;
      }
    }

    if (_autocompleteSuggestions.isNotEmpty) {
      setState(() {
        _autocompleteSuggestions = <EmojiData>[];
        _colonStartIndex = -1;
      });
    }
  }

  void _applyEmojiFromAutocomplete(EmojiData data) {
    final String text = _controller.text;
    final int cursor = _controller.selection.baseOffset;
    if (_colonStartIndex >= 0 && _colonStartIndex <= cursor && cursor <= text.length) {
      final String before = text.substring(0, _colonStartIndex);
      final String after = text.substring(cursor);
      final String replacement = '${data.emoji} ';
      final String newText = '$before$replacement$after';
      final int newCursor = before.length + replacement.length;

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newCursor),
      );
    } else {
      _insertEmojiAtCursor(data.emoji);
    }

    setState(() {
      _autocompleteSuggestions = <EmojiData>[];
      _colonStartIndex = -1;
    });
    _focusNode.requestFocus();
  }

  void _insertEmojiAtCursor(String emoji) {
    final String text = _controller.text;
    final TextSelection selection = _controller.selection;
    final int start = selection.isValid ? selection.start : text.length;
    final int end = selection.isValid ? selection.end : text.length;

    final String newText = text.replaceRange(start, end, emoji);
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: start + emoji.length),
    );
    _focusNode.requestFocus();
  }

  Future<void> _openEmojiPicker() async {
    await ChatInputEmojiPickerBottomSheet.show(
      context,
      onSelectEmoji: _insertEmojiAtCursor,
    );
  }

  Future<void> _handleSend() async {
    final ChatSignals chatSignals = kGetIt<ChatSignals>();
    if (chatSignals.isSending.value) {
      return;
    }

    final String rawText = _controller.text.trim();
    if (rawText.isEmpty) {
      return;
    }

    // Convertit les émoticônes résiduels (ex: fin de message sans espace: "salut :)")
    final String text = EmojiData.convertEmoticons(rawText);

    _controller.clear();
    setState(() {
      _autocompleteSuggestions = <EmojiData>[];
      _colonStartIndex = -1;
    });
    unawaited(chatSignals.setTyping(value: false));
    _focusNode.requestFocus();

    final bool success = await chatSignals.sendMessage(
      roomId: widget.roomId,
      plainText: text,
      peerPublicKeyBase64: widget.peerPublicKeyBase64,
    );
    if (success) {
      widget.onMessageSent?.call();
    }
  }

  Future<void> _handlePickMedia() async {
    final PickedMedia? media = await AppMediaPickerBottomSheet.show(
      context,
      title: 'Joindre un média chiffré',
      allowVideo: true,
    );
    if (media == null || !mounted) {
      return;
    }

    final ChatSignals chatSignals = kGetIt<ChatSignals>();
    final String text = _controller.text.trim();
    _controller.clear();
    unawaited(chatSignals.setTyping(value: false));

    final bool success = await chatSignals.sendMessage(
      roomId: widget.roomId,
      plainText: text,
      peerPublicKeyBase64: widget.peerPublicKeyBase64,
      mediaBytes: media.bytes,
      mediaFileName: media.fileName,
      mediaMimeType: media.mimeType,
    );
    if (success) {
      widget.onMessageSent?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatSignals chatSignals = kGetIt<ChatSignals>();

    return SignalBuilder(
      builder: (_) {
        final bool isSending = chatSignals.isSending.value;

        return Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: <Widget>[
            if (_autocompleteSuggestions.isNotEmpty)
              ChatEmojiAutocompletePopup(
                suggestions: _autocompleteSuggestions,
                onSelectEmoji: _applyEmojiFromAutocomplete,
              ),
            Container(
              padding: .only(
                left: AppSpacing.spaceSm.value,
                right: AppSpacing.spaceSm.value,
                top: AppSpacing.spaceSm.value,
                bottom: AppSpacing.spaceSm.value,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  spacing: AppSpacing.spaceSm.value,
                  children: <Widget>[
                    IconButton(
                      onPressed: isSending ? null : _handlePickMedia,
                      icon: Icon(Icons.add_photo_alternate_outlined, color: theme.colorScheme.primary),
                      tooltip: 'Joindre un média chiffré',
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        textCapitalization: .sentences,
                        textInputAction: .send,
                        maxLines: 4,
                        minLines: 1,
                        keyboardType: .multiline,
                        decoration: InputDecoration(
                          hintText: 'Message chiffré... (:pour emoji)',
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
                          border: OutlineInputBorder(borderRadius: .circular(AppRadius.bubble.value), borderSide: .none),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                          contentPadding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.sentiment_satisfied_alt_rounded,
                              color: theme.colorScheme.primary,
                              size: 22,
                            ),
                            tooltip: 'Émoticônes',
                            onPressed: isSending ? null : _openEmojiPicker,
                          ),
                        ),
                        onChanged: _onTextChanged,
                        onSubmitted: (_) => unawaited(_handleSend()),
                      ),
                    ),
                    if (isSending)
                      const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    else
                      const SizedBox(width: 18, height: 18),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
