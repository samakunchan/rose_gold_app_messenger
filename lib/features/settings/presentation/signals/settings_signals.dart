import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/clear_local_cache_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/export_user_data_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/save_exported_data_use_case.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SettingsSignals {
  new({
    required this.exportUserDataUseCase,
    required this.saveExportedDataUseCase,
    required this.clearLocalCacheUseCase,
  });

  final ExportUserDataUseCase exportUserDataUseCase;
  final SaveExportedDataUseCase saveExportedDataUseCase;
  final ClearLocalCacheUseCase clearLocalCacheUseCase;

  final Signal<bool> isExporting = Signal<bool>(false);
  final Signal<String?> exportedJson = Signal<String?>(null);
  final Signal<String?> exportError = Signal<String?>(null);
  final Signal<bool> isClearingCache = Signal<bool>(false);

  Future<void> generateDataExport() async {
    isExporting.value = true;
    exportError.value = null;

    final Either<Failure, String> result = await exportUserDataUseCase();
    result.fold(
      ifLeft: (Failure _) {
        exportError.value = "Impossible de générer l'export de vos données.";
      },
      ifRight: (String json) {
        exportedJson.value = json;
      },
    );

    isExporting.value = false;
  }

  Future<String?> saveCurrentExportToFile() async {
    final String? content = exportedJson.value;
    if (content == null || content.isEmpty) {
      return null;
    }

    final Either<Failure, String> result = await saveExportedDataUseCase(content);

    return await result.fold(
      ifLeft: (Failure _) => null,
      ifRight: (String path) => path,
    );
  }

  Future<int?> clearLocalCache() async {
    isClearingCache.value = true;
    final int clearedMedia = kGetIt.isRegistered<ChatSignals>() ? kGetIt<ChatSignals>().clearMediaCache() : 0;
    final Either<Failure, int> result = await clearLocalCacheUseCase();
    isClearingCache.value = false;

    return await result.fold(
      ifLeft: (Failure _) => null,
      ifRight: (int count) => count + clearedMedia,
    );
  }
}
