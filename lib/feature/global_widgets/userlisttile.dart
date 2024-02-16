import 'package:flutter/material.dart';
import 'package:tiktokclone/core/constants/constants.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';


class UserListTile extends StatelessWidget {
  const UserListTile({super.key});

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
              child: const SizedBox(
                height: 42,
                width: 42,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(AppString.testingUrl),
                ),
              ),
            ),
            horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "userName",
                  style: appTheme.displaySmall
                      ?.copyWith(fontSize: 15, color: Colors.black),
                ),
                Text(
                  'Pawan kumar',
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
