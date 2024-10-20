import 'package:flutter/material.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';

class UserListTile extends StatelessWidget {
  const UserListTile(
      {super.key,
      required this.userName,
      required this.firstname,
      required this.lastName,
      required this.userProfileImage});
  final String userName;
  final String firstname;
  final String lastName;
  final String userProfileImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: userProfileImage.isEmpty
                  ? const SizedBox(
                      height: 42,
                      width: 42,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(AppPaths.humanImage),
                      ),
                    )
                  : SizedBox(
                      height: 42,
                      width: 42,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(userProfileImage),
                      ),
                    ),
            ),
            horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: appTheme.displaySmall
                      ?.copyWith(fontSize: 15, color: Colors.black),
                ),
                Text(
                  '$firstname $lastName',
                  style: appTheme.headlineMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600),
                ),
                Row(
                  children: [
                    Text(
                      '16.9M followers • 187 Videos',
                      style: appTheme.headlineMedium?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  onPressed: () {},
                  child: Text(
                    'Follow',
                    style: appTheme.displaySmall,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
