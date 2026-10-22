import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FeedbackService {
  static Future<void> submitFeedback(BuildContext context, UserFeedback feedback, List<String> labels) async {
    try {
      final String nextcloudUrl = dotenv.get('NEXTCLOUD_URL');
      final String username = dotenv.get('NEXTCLOUD_USER');
      final String password = dotenv.get('NEXTCLOUD_PASSWORD');
      final String uploadPath = dotenv.get('NEXTCLOUD_UPLOAD_PATH');
      // final String githubRepoUrl = dotenv.get('GITHUB_REPO_URL');
      // final String githubToken = dotenv.get('GITHUB_ISSUE_TOKEN');

      // Gather Device & Package Info
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String deviceDescription = '';
      String deviceModel = 'unknown';
      // String labelPlatform = 'unknown';

      if (kIsWeb) {
        final WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        deviceModel = webBrowserInfo.browserName.name;
        deviceDescription = 'Web: $deviceModel ${webBrowserInfo.appVersion}';
        // labelPlatform = 'web';
      } else {
        if (Platform.isAndroid) {
          final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceModel = '${androidInfo.manufacturer}-${androidInfo.model}';
          deviceDescription = 'Android: ${androidInfo.manufacturer} ${androidInfo.model} (SDK ${androidInfo.version.sdkInt})';
          // labelPlatform = 'android';
        } else if (Platform.isIOS) {
          final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceModel = iosInfo.utsname.machine;
          deviceDescription = 'iOS: ${iosInfo.name} ${iosInfo.systemName} ${iosInfo.systemVersion} ($deviceModel)';
          // labelPlatform = 'ios';
        } else if (Platform.isMacOS) {
          final MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
          deviceModel = macOsInfo.model;
          deviceDescription = 'macOS: $deviceModel ${macOsInfo.osRelease}';
          // labelPlatform = 'macos';
        } else {
          deviceDescription = 'Unknown Platform';
        }
      }

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
| **Feedback is from** | ${labels.map((String label) => '${labels.last == label ? label : '$label,'} ').toList()} |
''';

      // Format Filename: [YYYYMMDD]-feedback-[deviceDescription].png
      final String datePart = DateFormat('yyyyMMdd').format(DateTime.now());
      // Sanitize deviceModel for filename (alphanumeric and hyphens only)
      final String sanitizedDevice = deviceModel.replaceAll(RegExp(r'[^a-zA-Z0-9\-]'), '_');
      final String filename = '$datePart-feedback-$sanitizedDevice-${DateTime.now().millisecondsSinceEpoch}.png';

      final String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      // 1. Upload to Nextcloud WebDAV
      final String fullUploadPath = '$nextcloudUrl/remote.php/dav/files/$username/$uploadPath/$filename';

      if (kDebugMode) {
        print(appInfoSection);
        print(basicAuth);
        print(fullUploadPath);
      }
      // final http.Response uploadResponse = await http.put(
      //   Uri.parse(fullUploadPath),
      //   headers: {'Authorization': basicAuth},
      //   body: feedback.screenshot,
      // );
      //
      // if (uploadResponse.statusCode != 201 && uploadResponse.statusCode != 204) {
      //   throw Exception('Failed to upload to Nextcloud: ${uploadResponse.statusCode}');
      // }
      //
      // // 2. Share via OCS API
      // final http.Response shareResponse = await http.post(
      //   Uri.parse('$nextcloudUrl/ocs/v2.php/apps/files_sharing/api/v1/shares?format=json'),
      //   headers: {
      //     'Authorization': basicAuth,
      //     'OCS-APIRequest': 'true',
      //   },
      //   body: {
      //     'path': '$uploadPath/$filename',
      //     'shareType': '3', // 3 = Public link
      //   },
      // );
      //
      // if (shareResponse.statusCode == 200) {
      //   final Map<String, dynamic> data = jsonDecode(shareResponse.body) as Map<String, dynamic>;
      //   final String publicLink = ((data['ocs'] as Map<String, dynamic>)['data'] as Map<String, dynamic>)['url'] as String;
      //
      //   // 3. Create GitHub Issue
      //   final Uri githubUri = Uri.parse(githubRepoUrl);
      //   final List<String> segments = githubUri.pathSegments.where((String s) => s.isNotEmpty).toList();
      //   final String apiOwner = segments[segments.length - 2];
      //   final String apiRepo = segments.last;
      //
      //   final String apiUrl = 'https://api.github.com/repos/$apiOwner/$apiRepo/issues';
      //
      //   final String issueBody =
      //       '${feedback.text}\n\n<div align="center"><img src="$publicLink/preview" alt="Feedback Screenshot" width="300" /></div>\n\n[View Full Image]($publicLink)\n\n$appInfoSection';
      //
      //   final String feedbackCategory = feedback.extra?['type']?.toString() ?? 'Autre';
      //   final http.Response issueResponse = await http.post(
      //     Uri.parse(apiUrl),
      //     headers: {
      //       'Authorization': 'token $githubToken',
      //       'Accept': 'application/vnd.github.v3+json',
      //       'Content-Type': 'application/json',
      //     },
      //     body: jsonEncode({
      //       'title': 'App Feedback $deviceDescription',
      //       'body': issueBody,
      //       'labels': ['feedback', labelPlatform, ...labels, feedbackCategory],
      //     }),
      //   );
      //
      //   if (issueResponse.statusCode != 201) {
      //     throw Exception('Failed to create GitHub issue: ${issueResponse.statusCode} ${issueResponse.body}');
      //   }
      //
      //   if (kDebugMode) {
      //     print('Feedback sent successfully!');
      //   }
      // } else {
      //   throw Exception('Failed to share file: ${shareResponse.body}');
      // }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error submitting feedback: $e');
        print(stackTrace);
      }

      rethrow;
    }
  }
}
