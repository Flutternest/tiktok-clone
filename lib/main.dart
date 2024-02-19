import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tiktokclone/core/theme/app_theme.dart';
import 'package:tiktokclone/feature/auth/login_email.dart';
import 'package:tiktokclone/feature/auth/signin_page.dart';
import 'package:tiktokclone/feature/auth/signup_page.dart';
import 'package:tiktokclone/feature/home/base_page.dart';
import 'package:tiktokclone/feature/home/home_page.dart';
import 'package:tiktokclone/feature/post/creating_post.dart';
import 'package:tiktokclone/feature/profile/edit_profile.dart';
import 'package:tiktokclone/feature/profile/profile_page.dart';
import 'package:tiktokclone/feature/search/search_screen.dart';
import 'package:tiktokclone/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/signup': (context) => SignUp(),
        '/loginemail': (context) => LoginEmail(),
        '/homepage': (context) => HomePage(),
        '/profilepage': (context) => const ProfilePage(),
        "/searchPage": (context) => const SearchScreen(),
        '/editProfilePage': (context) => const EditProfile(),
        '/basePage': (context) => const BasePage(),
        '/creatingPost': (context) => const CreatingPost(),
      },
      theme: commonTheme,
    );
  }
}
