import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiktokclone/core/router/app_router.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/auth/repositary/auth_repositary.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passwordVisibility = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.router.pop();
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
      body: Form(
        key: _formKey,
        child: CommonPadding(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 150,
                ),
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
                  validator: AppUtils.fieldEmpty,
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        final user = await ref
                            .read(authRepositoryProvider)
                            .signUp(
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                        user.fold((error) {
                          Fluttertoast.showToast(msg: error.message);
                          setState(() {
                            isLoading = false;
                          });
                        }, (right) {
                          setState(() {
                            isLoading = false;
                          });
                          context.router.push(const BaseRoute());
                        });
                      }
                    },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'SignUp',
                            style: appTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
