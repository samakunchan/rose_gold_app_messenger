import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/di/auth_d_i.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt kGetIt = GetIt.instance;
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

Future<void> initDI() async {
  /// Shared Preferences
  final SharedPreferencesWithCache preferences = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{
        'local_theme_mode',
        'local_font_size',
        'local_font_family',
        'local_language',
      },
    ),
  );

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  kGetIt
    ..registerSingleton<PackageInfo>(packageInfo)
    ..registerSingleton<SupabaseClient>(Supabase.instance.client)
    ..registerSingleton<SharedPreferencesWithCache>(preferences)
    ..registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage())
  //
  ;
  initSupabaseAuthDI();
}
