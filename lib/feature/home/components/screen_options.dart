import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/home/components/user_profile_image.dart';
import 'package:tiktokclone/feature/home/modals/reel_model.dart';
import 'package:tiktokclone/feature/home/utils/convert_numbers_to_short.dart';

import 'comment_bottomsheet.dart';

class ScreenOptions extends StatelessWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;

  const ScreenOptions({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Following',
                  style: appTheme.displaySmall,
                )),
            Container(
              height: 15,
              width: 2,
              decoration: const BoxDecoration(color: Colors.white),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'For You',
                  style: appTheme.displaySmall,
                )),
          ],
        ),
        const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 200),
                  Text(
                    "@${item.userName}",
                    style: appTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  const SizedBox(width: 6),
                  if (item.reelDescription != null)
                    Text(
                      item.reelDescription ?? '',
                      style: appTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  const SizedBox(height: 10),
                  if (item.musicName != null)
                    Row(
                      children: [
                        SvgPicture.asset(SvgPaths.musicIcon),
                        horizontalSpaceTiny,
                        Text(
                          'Original Audio - ${item.musicName}',
                          style: appTheme.headlineSmall?.copyWith(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Column(
              children: [
                UserProfileImage(profileUrl: item.profileUrl ?? ''),
                verticalSpaceMedium,
                if (onLike != null && !item.isLiked)
                  IconButton(
                    iconSize: 34,
                    onPressed: onLike!(item.url),
                    icon: SvgPicture.asset(SvgPaths.heartIcon),
                  ),
                if (item.isLiked)
                  IconButton(
                    iconSize: 34,
                    onPressed: () {},
                    icon: SvgPicture.asset(SvgPaths.heartIcon),
                  ),
                Text(NumbersToShort.convertNumToShort(item.likeCount),
                    style: appTheme.displaySmall),
                const SizedBox(height: 20),
                IconButton(
                  iconSize: 34,
                  icon: SvgPicture.asset(
                    SvgPaths.commentIcon,
                  ),
                  onPressed: () {
                    if (onComment != null) {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (ctx) => CommentBottomSheet(
                              commentList: item.commentList ?? [],
                              onComment: onComment));
                    }
                  },
                ),
                Text(
                    NumbersToShort.convertNumToShort(
                        item.commentList?.length ?? 0),
                    style: appTheme.displaySmall),
                const SizedBox(height: 20),
                if (onShare != null)
                  IconButton(
                    iconSize: 34,
                    icon: SvgPicture.asset(SvgPaths.shareIcon),
                    onPressed: onShare!(item.url),
                    color: Colors.white,
                  ),
                Text("Share", style: appTheme.displaySmall),
                const SizedBox(height: 20),
                if (onClickMoreBtn != null)
                  IconButton(
                    iconSize: 50,
                    icon: SvgPicture.asset(SvgPaths.discIcon),
                    onPressed: onClickMoreBtn!,
                    color: Colors.white,
                  ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
