import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktokclone/core/provider/prefs_provider.dart';
import 'package:tiktokclone/core/router/app_router.dart';
import 'package:tiktokclone/core/theme/app_theme.dart';
import 'package:tiktokclone/feature/auth/signin_page.dart';
import 'package:tiktokclone/feature/auth/welcome_page.dart';
import 'package:tiktokclone/feature/auth/signup_page.dart';
import 'package:tiktokclone/feature/home/base_page.dart';
import 'package:tiktokclone/feature/home/home_page.dart';
import 'package:tiktokclone/feature/post/creating_post.dart';
import 'package:tiktokclone/feature/user/edit_profile.dart';
import 'package:tiktokclone/feature/user/profile_page.dart';
import 'package:tiktokclone/feature/search/search_screen.dart';
import 'package:tiktokclone/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
      overrides: [prefsProvider.overrideWithValue(prefs)],
      child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget with WidgetsBindingObserver {
  const MyApp({super.key});
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('previous state ${AppLifecycleState}');
    print("state is ${state}");
    super.didChangeAppLifecycleState(state);
  }

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> checkUserIsFirstTime() async {
    final data = ref.read(prefsProvider).get('checkUser');
    if (data == null) {
      await ref.read(prefsProvider).setBool('checkUser', true);
      await auth.signOut();
    }
  }

  @override
  void initState() {
    checkUserIsFirstTime();
    _clearCache();
    super.initState();
  }

  Future<void> _clearCache() async {
    await DefaultCacheManager().emptyCache();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
      theme: commonTheme,
    );
  }
}
