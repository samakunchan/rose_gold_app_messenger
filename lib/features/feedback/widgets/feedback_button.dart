import 'package:feedback/feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/feedback/services/feedback_service.dart';

class FeedbackButton extends StatelessWidget {
  const new({super.key, this.labels = const <String>[]});
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.bug_report),
      onPressed: () {
        BetterFeedback.of(context).show((UserFeedback feedback) => FeedbackService.submitFeedback(context, feedback, labels));
      },
    );
  }
}
