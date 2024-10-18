import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';

class AppBottomBarWidget extends StatelessWidget {
  const AppBottomBarWidget(
      {this.onTap,
      required this.key,
      required this.svgPath,
      required this.textColor,
      required this.iconColor,
      required this.title});
  final GestureTapCallback? onTap;
  final Key? key;
  final String svgPath;
  final Color textColor;
  final Color iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        radius: 100,
        splashColor: Colors.pink[100],
        onTap: onTap,
        key: key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              color: iconColor,
            ),
            verticalSpaceTiny,
            Text(
              title,
              style: appTheme.displaySmall
                  ?.copyWith(color: textColor, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
