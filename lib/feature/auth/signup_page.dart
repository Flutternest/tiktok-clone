import 'package:flutter/material.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

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
          'SignUp',
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
              'First Name',
              style: appTheme.headlineMedium?.copyWith(
                fontSize: 15,
              ),
            ),
            verticalSpaceTiny,
            TextFormField(
              keyboardType: TextInputType.name,
              validator: AppUtils.fieldEmpty,
              controller: firstNameController,
              decoration: const InputDecoration(hintText: 'First Name'),
            ),
            verticalSpaceSmall,
            Text(
              'Last Name',
              style: appTheme.headlineMedium?.copyWith(
                fontSize: 15,
              ),
            ),
            verticalSpaceTiny,
            TextFormField(
              keyboardType: TextInputType.name,
              validator: AppUtils.emailValidate,
              controller: lastNameController,
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
            verticalSpaceSmall,
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
              decoration: const InputDecoration(hintText: 'Enter mail'),
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
            verticalSpaceRegular,
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
