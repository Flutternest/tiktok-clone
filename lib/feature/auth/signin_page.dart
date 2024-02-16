import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'TikTok',
          style: appTheme.headlineMedium?.copyWith(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30),
        )),
      ),
      body: CommonPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Text('Login in to TikTok',
                      style:
                          appTheme.headlineSmall?.copyWith(letterSpacing: .5)),
                ),
                Text(
                  'Manage your account, check notifications, comment om video and more.',
                  textAlign: TextAlign.center,
                  style: appTheme.headlineMedium?.copyWith(color: Colors.grey),
                ),
                verticalSpaceSmall,
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginemail');
                    },
                    child: Text(
                      'Email',
                      style: appTheme.headlineMedium
                          ?.copyWith(color: Colors.black),
                    )),
                verticalSpaceSmall,
                SignInWithAppleButton(onPressed: () {
                  Navigator.pushNamed(context, '/homepage');
                }),
                verticalSpaceSmall,
                OutlinedButton(
                    style: OutlinedButton.styleFrom(),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(SvgPaths.googleIcon),
                        horizontalSpaceTiny,
                        Text(
                          'Continue with google',
                          style: appTheme.headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'By continuing you agree to our ',
                    style: appTheme.headlineMedium
                        ?.copyWith(color: Colors.grey.shade500, fontSize: 15),
                  ),
                  TextSpan(
                      text: 'Terms of service',
                      style: appTheme.headlineSmall?.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  TextSpan(
                    text: ' and acknowledge het you have read our',
                    style: appTheme.headlineMedium
                        ?.copyWith(color: Colors.grey.shade500, fontSize: 15),
                  ),
                  TextSpan(
                      text: ' Privacy Policy',
                      style: appTheme.headlineSmall?.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  TextSpan(
                    text: ' to learn how e collect , use and share your data',
                    style: appTheme.headlineMedium
                        ?.copyWith(color: Colors.grey.shade500, fontSize: 15),
                  ),
                ])),
                verticalSpaceRegular,
                SizedBox(
                  height: 70,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200),
                      onPressed: () {
                        Navigator.pushNamed(context, '/basePage');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            ' Sign Up',
                            style: appTheme.headlineMedium
                                ?.copyWith(color: Colors.pink),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
