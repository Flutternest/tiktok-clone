import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/router/app_router.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/core/utility/mixins/full_page_progress_mixin.dart';
import 'package:tiktokclone/feature/auth/repositary/auth_repositary.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';
import 'package:tiktokclone/feature/home/base_page.dart';

@RoutePage()
class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  ConsumerState<WelcomePage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<WelcomePage>
    with FullPageProgressMixin {
  // apple login
  Future<void> continueWithApple(BuildContext context) async {
    showLoader(context, () async {
      final result = await ref.read(authRepositoryProvider).appleSignIn();
      result.fold((left) {
        Fluttertoast.showToast(msg: left.message);
      }, (right) {
        context.router.push(BaseRoute());
      });
    });
  }

// google login
  Future<void> continueWithGoogle(BuildContext context) async {
    showLoader(context, () async {
      final result = await ref.read(authRepositoryProvider).googleSignIn();
      result.fold((left) {
        Fluttertoast.showToast(msg: left.message);
      }, (right) {
        context.router.push(BaseRoute());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'TikTok',
          style: appTheme.headlineMedium?.copyWith(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30),
        )),
      ),
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return CommonPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildHeader(),
                buildSignInOptions(context),
                buildFooter(context)
              ],
            ),
          );
        }),
      ),
    );
  }

  Column buildSignInOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
          onPressed: () {
            context.router.push(SignInRoute());
          },
          child: Text(
            'Email',
            style: appTheme.headlineMedium?.copyWith(color: Colors.black),
          ),
        ),
        verticalSpaceSmall,
        SignInWithAppleButton(onPressed: () => continueWithApple(context)),
        verticalSpaceSmall,
        OutlinedButton(
          style: OutlinedButton.styleFrom(),
          onPressed: () => continueWithGoogle(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(SvgPaths.googleIcon),
              horizontalSpaceTiny,
              Text(
                'Continue with google',
                style: appTheme.headlineMedium?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildHeader() {
    return Column(
      children: [
        Center(
          child: Text('Login in to TikTok',
              style: appTheme.headlineSmall?.copyWith(letterSpacing: .5)),
        ),
        Text(
          'Manage your account, check notifications, comment om video and more.',
          textAlign: TextAlign.center,
          style: appTheme.headlineMedium?.copyWith(color: Colors.grey),
        ),
        verticalSpaceSmall,
      ],
    );
  }

  Column buildFooter(BuildContext context) {
    return Column(
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
            text: 'By continuing you agree to our ',
            style: appTheme.headlineMedium
                ?.copyWith(color: Colors.grey.shade500, fontSize: 15),
          ),
          TextSpan(
              text: 'Terms of service ',
              style: appTheme.headlineSmall
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
          TextSpan(
            text: 'and acknowledge het you have read our ',
            style: appTheme.headlineMedium
                ?.copyWith(color: Colors.grey.shade500, fontSize: 15),
          ),
          TextSpan(
              text: 'Privacy Policy ',
              style: appTheme.headlineSmall
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
          TextSpan(
            text: 'to learn how e collect, use and share your data',
            style: appTheme.headlineMedium
                ?.copyWith(color: Colors.grey.shade500, fontSize: 15),
          ),
        ])),
        verticalSpaceRegular,
        SizedBox(
          height: 70,
          child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200),
            onPressed: () {
              context.router.push(SignUpRoute());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Sign Up',
                  style: appTheme.headlineMedium?.copyWith(color: Colors.pink),
                ),
              ],
            ),
          ),
        ),
        verticalSpaceMedium,
      ],
    );
  }
}
