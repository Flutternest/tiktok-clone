import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';
import 'package:tiktokclone/feature/search/provider/fetch_users.dart';
import 'package:tiktokclone/feature/user/provider/user_provider.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';

@RoutePage()
class ChangeNamePage extends ConsumerStatefulWidget {
  const ChangeNamePage(
      {super.key,
      required this.uid,
      required this.firstName,
      required this.lastName});
  final String firstName;
  final String lastName;
  final String uid;

  @override
  ConsumerState<ChangeNamePage> createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends ConsumerState<ChangeNamePage> {
  final TextEditingController firstNameTextEditingController =
      TextEditingController();

  final TextEditingController lastNameTextEditingController =
      TextEditingController();

  bool isLoading = false;
  @override
  void initState() {
    firstNameTextEditingController.text = widget.firstName;
    lastNameTextEditingController.text = widget.lastName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Name',
          style: appTheme.displaySmall
              ?.copyWith(color: Colors.black, fontSize: 15),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              final res = await ref
                  .read(userRepositaryProvider)
                  .changeNameInUserProfile(
                      FirebaseAuth.instance.currentUser!.uid,
                      firstNameTextEditingController.text,
                      lastNameTextEditingController.text);
              res.fold((left) {
                Fluttertoast.showToast(msg: 'something went wrong');
              }, (right) {
                ref.invalidate(fetchProfileDataProvider);
                context.router.pop();
              });
              setState(() {
                isLoading = false;
              });
            },
            icon: isLoading
                ? const CircularProgressIndicator()
                : const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
          ),
          horizontalSpaceRegular,
        ],
      ),
      body: SafeArea(
          child: CommonPadding(
        child: Column(
          children: [
            verticalSpaceMedium,
            TextFormField(
              keyboardType: TextInputType.name,
              validator: AppUtils.fieldEmpty,
              controller: firstNameTextEditingController,
              decoration: const InputDecoration(hintText: 'First Name'),
            ),
            verticalSpaceRegular,
            TextFormField(
              keyboardType: TextInputType.name,
              validator: AppUtils.fieldEmpty,
              controller: lastNameTextEditingController,
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
          ],
        ),
      )),
    );
  }
}
