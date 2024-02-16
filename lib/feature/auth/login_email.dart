import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

import '../../core/theme/text_theme.dart';

class LoginEmail extends StatefulWidget {
  LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Login',
          style: appTheme.headlineMedium?.copyWith(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
      body: CommonPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email',
              style: appTheme.headlineMedium?.copyWith(
                fontSize: 15,
              ),
            ),
            verticalSpaceTiny,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: AppUtils.emailValidate,
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Enter email'),
            ),
            verticalSpaceSmall,
            Text(
              'Password',
              style: appTheme.headlineMedium?.copyWith(
                fontSize: 15,
              ),
            ),
            verticalSpaceTiny,
            TextFormField(
              controller: passwordController,
              validator: AppUtils.passwordValidate,
              obscureText: passwordVisibility,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passwordVisibility = !passwordVisibility;
                      });
                    },
                    child: Icon(
                      passwordVisibility
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xffD0DCC7),
                    ),
                  ),
                  hintText: 'password'),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget Password ?',
                    style: appTheme.headlineMedium?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  )),
            ),
            verticalSpaceSmall,
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Login',
                  style: appTheme.headlineMedium?.copyWith(
                      color: Colors.grey.shade500, fontWeight: FontWeight.w700),
                )),
          ],
        ),
      ),
    ));
  }
}
