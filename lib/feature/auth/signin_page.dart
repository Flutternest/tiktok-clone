import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiktokclone/core/provider/is_loading_provider.dart';
import 'package:tiktokclone/core/router/app_router.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/auth/repositary/auth_repositary.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

import '../../core/theme/text_theme.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});
  @override
  ConsumerState<SignInPage> createState() => _LoginEmailState();
}

class _LoginEmailState extends ConsumerState<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // login
  Future<void> performLogin() async {
    if (_formKey.currentState!.validate()) {
      ref.read(isLoadingProvider.notifier).state = true;
      final user = await ref.read(authRepositoryProvider).signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      user.fold((error) {
        ref.read(isLoadingProvider.notifier).state = false;
        Fluttertoast.showToast(msg: error.message);
      }, (right) {
        ref.read(isLoadingProvider.notifier).state = false;
        context.router.push(const BaseRoute());
      });
    }
  }

  bool passwordVisibility = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
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
          'Login',
          style: appTheme.headlineMedium?.copyWith(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
      body: CommonPadding(
        child: Form(
          key: _formKey,
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
                  onPressed: performLogin,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : Text(
                          'Login',
                          style: appTheme.headlineMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        )),
            ],
          ),
        ),
      ),
    ));
  }
}
