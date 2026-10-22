import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/feedback/signals/feed_back_store.dart';

void initFeedbackDI() {
  kGetIt
  /// Feedbacks
  .registerLazySingleton<FeedBackStore>(FeedBackStore.new)
  //
  ;
}
