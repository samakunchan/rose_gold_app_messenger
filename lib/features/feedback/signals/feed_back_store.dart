import 'package:signals_flutter/signals_core.dart';

List<String> feedbackTypes = <String>['bug', 'enhancement', 'other'];

class FeedBackStore {
  final Signal<List<String>> mainScreenLabels = Signal<List<String>>(
    const <String>['roomscreen', 'messengerscreen'],
    options: const .new(name: ' MAIN SCREEN LABELS '),
  );

  void updatePage(int pageIndex) {
    if (pageIndex == 0) {
      mainScreenLabels.value = const <String>['roomscreen', 'messengerscreen'];
    } else {
      mainScreenLabels.value = const <String>['roomscreen', 'studioscreen'];
    }
  }
}
