import 'package:flutter/material.dart';
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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUp(),
        '/loginemail': (context) => LoginEmail(),
        '/homepage': (context) => HomePage(),
        '/profilepage': (context) => ProfilePage(),
        "/searchPage": (context) => SearchScreen(),
        '/editProfilePage': (context) => EditProfile(),
        '/basePage': (context) => BasePage(),
        '/creatingPost': (context) => CreatingPost(),
      },
      theme: commonTheme,
    );
  }
}
