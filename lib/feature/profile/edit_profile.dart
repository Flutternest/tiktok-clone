import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Text(
          'Edit Profile',
          style: appTheme.displaySmall?.copyWith(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
      body: CommonPadding(
        child: Column(
          children: [
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            verticalSpaceMoreThanMedium,
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 40,
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
                leadingTitle: 'Name', trailingTitle: 'pawa kumar'),
            buildProfileItemListTile(
                leadingTitle: 'Username', trailingTitle: 'pawan123'),
            buildProfileItemListTile(
                leadingTitle: 'Bio',
                trailingTitle: 'Add a bio to your profile'),
          ],
        ),
      ),
    ));
  }
}

Widget buildProfileItemListTile(
    {required String leadingTitle, required String trailingTitle}) {
  return Padding(
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
            Icon(
              Icons.keyboard_arrow_right,
              color: Color(0xff86878B),
            )
          ],
        ),
      ],
    ),
  );
}
