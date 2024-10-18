import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiktokclone/core/router/app_router.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';
import 'package:tiktokclone/feature/user/change_bio_page.dart';
import 'package:tiktokclone/feature/user/provider/user_provider.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';

@RoutePage()
class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(fetchProfileDataProvider(uid));
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: appTheme.displaySmall?.copyWith(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
      body: CommonPadding(
        child: userData.when(
            data: (user) => user.isLeft
                ? SizedBox(
                    child: Text(user.left.message),
                  )
                : Column(
                    children: [
                      const Divider(
                        height: 1,
                        color: Colors.black,
                      ),
                      verticalSpaceMoreThanMedium,
                      InkWell(
                        onTap: () async {
                          final image = await AppUtils.pickImageFromCamera();
                          if (image != null) {
                            final res = await ref
                                .read(userRepositaryProvider)
                                .changeProfilePic(uid, image);
                            ref.invalidate(fetchProfileDataProvider);
                            res.fold((left) {
                              Fluttertoast.showToast(msg: left.message);
                            }, (right) {
                              Fluttertoast.showToast(
                                  msg: 'profile pic uploaded successfully');
                            });
                          }
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: user.right.profileUrl.isEmpty
                                ? null
                                : DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(user.right.profileUrl)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      verticalSpaceRegular,
                      Text(
                        'Change Photo',
                        style: appTheme.displaySmall?.copyWith(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
                      ),
                      verticalSpaceMoreThanMedium,
                      buildProfileItemListTile(
                          leadingTitle: 'Name',
                          trailingTitle:
                              "${user.right.firstName}${user.right.lastName}",
                          onTap: () {
                            context.router.push(ChangeNameRoute(
                                uid: uid,
                                firstName: user.right.firstName,
                                lastName: user.right.lastName));
                          }),
                      buildProfileItemListTile(
                          leadingTitle: 'Username',
                          trailingTitle: user.right.userName,
                          onTap: () {}),
                      buildProfileItemListTile(
                          leadingTitle: 'Bio',
                          trailingTitle: user.right.bio.isEmpty
                              ? 'Add a bio to your profile'
                              : user.right.bio,
                          onTap: () {
                            context.router.push(
                                ChangeBioRoute(bio: user.right.bio, uid: uid));
                          }),
                    ],
                  ),
            error: (e, st) => Text(e.toString()),
            loading: () => const CircularProgressIndicator()),
      ),
    ));
  }
}

Widget buildProfileItemListTile({
  required GestureTapCallback? onTap,
  required String leadingTitle,
  required String trailingTitle,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingTitle,
            style: appTheme.displaySmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          Row(
            children: [
              Text(
                trailingTitle,
                style: appTheme.displaySmall?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xff86878B),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
