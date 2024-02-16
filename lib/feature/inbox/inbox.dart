import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

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
          'Direct Messages',
          style: appTheme.displaySmall?.copyWith(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [
          Icon(
            Icons.add,
            color: Colors.black,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              SvgPaths.messageIcon,
              color: Colors.grey,
              height: 70,
              width: 60,
            ),
            verticalSpaceRegular,
            Text(
              'Message your friends',
              style: appTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
            verticalSpaceSmall,
            Text(
              'Share video or start a converstion',
              style:
                  appTheme.headlineMedium?.copyWith(color: Color(0xff86878B)),
            )
          ],
        ),
      ),
    ));
  }
}
