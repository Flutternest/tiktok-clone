import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/feature/auth/signin_page.dart';
import 'package:tiktokclone/feature/auth/signup_page.dart';
import 'package:tiktokclone/feature/auth/welcome_page.dart';
import 'package:tiktokclone/feature/home/base_page.dart';
import 'package:tiktokclone/feature/home/home_page.dart';
import 'package:tiktokclone/feature/post/creating_post.dart';
import 'package:tiktokclone/feature/post/video_editor.dart';
import 'package:tiktokclone/feature/user/change_bio_page.dart';
import 'package:tiktokclone/feature/user/change_name_page.dart';
import 'package:tiktokclone/feature/user/edit_profile.dart';
import 'package:tiktokclone/feature/user/profile_page.dart';
import 'package:tiktokclone/feature/search/search_screen.dart';
part 'app_router.gr.dart';

final routerProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(
            page: WelcomeRoute.page,
            initial: FirebaseAuth.instance.currentUser == null ? true : false),
        AutoRoute(
            page: BaseRoute.page,
            initial: FirebaseAuth.instance.currentUser == null ? false : true),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: CreatingPostRoute.page),
        AutoRoute(page: ChangeNameRoute.page),
        AutoRoute(page: VideoEditorRoute.page),
        AutoRoute(page: ChangeBioRoute.page),
      ];
}
