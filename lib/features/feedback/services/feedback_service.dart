import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackService {
  static const String _bucketName = 'feedbacks';

  static Future<void> submitFeedback(BuildContext context, UserFeedback feedback, List<String> labels) async {
    try {
      final String githubRepoUrl = dotenv.get('GITHUB_REPO_URL');
      final String githubToken = dotenv.get('GITHUB_ISSUE_TOKEN');

      final SupabaseClient supabase = kGetIt<SupabaseClient>();
      final String userId = supabase.auth.currentUser?.id ?? 'anonymous';

      // Gather Device & Package Info
      final PackageInfo packageInfo = kGetIt<PackageInfo>();
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String deviceDescription = '';
      String deviceModel = 'unknown';
      String labelPlatform = 'unknown';

      if (kIsWeb) {
        final WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        deviceModel = webBrowserInfo.browserName.name;
        deviceDescription = 'Web: $deviceModel ${webBrowserInfo.appVersion}';
        labelPlatform = 'web';
      } else {
        if (Platform.isAndroid) {
          final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceModel = '${androidInfo.manufacturer}-${androidInfo.model}';
          deviceDescription = 'Android: ${androidInfo.manufacturer} ${androidInfo.model} (SDK ${androidInfo.version.sdkInt})';
          labelPlatform = 'android';
        } else if (Platform.isIOS) {
          final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceModel = iosInfo.utsname.machine;
          deviceDescription = 'iOS: ${iosInfo.name} ${iosInfo.systemName} ${iosInfo.systemVersion} ($deviceModel)';
          labelPlatform = 'ios';
        } else if (Platform.isMacOS) {
          final MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
          deviceModel = macOsInfo.model;
          deviceDescription = 'macOS: $deviceModel ${macOsInfo.osRelease}';
          labelPlatform = 'macos';
        } else {
          deviceDescription = 'Unknown Platform';
        }
      }

      final String feedbackCategory = feedback.extra?['type']?.toString() ?? 'other';

      final String appInfoSection =
          '''
## App & Device Info
| Key | Value |
| -- | -- |
| **App Name** | ${packageInfo.appName} |
| **Package Name** | ${packageInfo.packageName} |
| **Version** | ${packageInfo.version} |
| **Build Number** | ${packageInfo.buildNumber} |
| **Device** | $deviceDescription |
| **User ID** | `$userId` |
| **Category** | `$feedbackCategory` |
| **Feedback is from** | ${labels.join(', ')} |
''';

      // Format Filename: [YYYYMMDD]-feedback-[deviceDescription]-[timestamp].png
      final String datePart = DateFormat('yyyyMMdd').format(DateTime.now());
      final String sanitizedDevice = deviceModel.replaceAll(RegExp(r'[^a-zA-Z0-9\-]'), '_');
      final String filename = '$datePart-feedback-$sanitizedDevice-${DateTime.now().millisecondsSinceEpoch}.png';
      final String storagePath = '$userId/$filename';

      // 1. Upload screenshot to Supabase Storage bucket 'feedbacks'
      await supabase.storage
          .from(_bucketName)
          .uploadBinary(
            storagePath,
            feedback.screenshot,
            fileOptions: const FileOptions(contentType: 'image/png', upsert: true),
          );

      // 2. Retrieve public URL from Supabase Storage
      final String publicLink = supabase.storage.from(_bucketName).getPublicUrl(storagePath);

      // 3. Create GitHub Issue
      final Uri githubUri = Uri.parse(githubRepoUrl);
      final List<String> segments = githubUri.pathSegments.where((String s) => s.isNotEmpty).toList();
      final String apiOwner = segments[segments.length - 2];
      final String apiRepo = segments.last;

      final String apiUrl = 'https://api.github.com/repos/$apiOwner/$apiRepo/issues';

      final String issueBody =
          '${feedback.text}\n\n<div align="center"><img src="$publicLink" alt="Feedback Screenshot" width="300" /></div>\n\n[View Full Image]($publicLink)\n\n$appInfoSection';

      final http.Response issueResponse = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $githubToken',
          'Accept': 'application/vnd.github+json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'title': '[$feedbackCategory] App Feedback - $deviceDescription',
          'body': issueBody,
          'labels': <String>['feedback', labelPlatform, ...labels, feedbackCategory],
        }),
      );

      if (issueResponse.statusCode != 201) {
        throw Exception('Failed to create GitHub issue: ${issueResponse.statusCode} ${issueResponse.body}');
      }

      final BuildContext? activeContext = rootNavigatorKey.currentContext ?? (context.mounted ? context : null);
      if (activeContext != null && activeContext.mounted) {
        ScaffoldMessenger.of(activeContext).showSnackBar(
          const SnackBar(
            content: Text('Merci ! Votre retour a bien été envoyé.'),
          ),
        );
      }
    } on Exception catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error submitting feedback: $e');
        print(stackTrace);
      }

      final BuildContext? activeContext = rootNavigatorKey.currentContext ?? (context.mounted ? context : null);
      if (activeContext != null && activeContext.mounted) {
        ScaffoldMessenger.of(activeContext).showSnackBar(
          SnackBar(content: Text("Erreur lors de l'envoi du retour : $e")),
        );
      }

      rethrow;
    }
  }
}
