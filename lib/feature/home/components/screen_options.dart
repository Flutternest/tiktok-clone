import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/home/components/user_profile_image.dart';
import 'package:tiktokclone/feature/home/home_page.dart';
import 'package:tiktokclone/feature/home/modals/reel_model.dart';
import 'package:tiktokclone/feature/home/shimmer/home_page_shimmer.dart';
import 'package:tiktokclone/feature/home/utils/convert_numbers_to_short.dart';
import 'package:tiktokclone/feature/feed/modal/feed.dart';
import 'package:tiktokclone/feature/user/provider/user_provider.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';

import '../../comment/views/comment_bottomsheet.dart';

class ScreenOptions extends ConsumerStatefulWidget {
  final Feed item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final String createdBy;

  const ScreenOptions({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    required this.createdBy,
  }) : super(key: key);

  @override
  ConsumerState<ScreenOptions> createState() => _ScreenOptionsState();
}

class _ScreenOptionsState extends ConsumerState<ScreenOptions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 50), vsync: this, value: 1.0);

  int likeCount = 0;
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(fetchProfileDataProvider(widget.createdBy));
    return userData.when(
      data: (data) {
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.isRight ? data.right.userName : '',
                        maxLines: 1,
                        style: appTheme.headlineSmall?.copyWith(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (widget.item.description != null)
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text(
                            widget.item.description ?? '',
                            maxLines: 2,
                            style: appTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(SvgPaths.musicIcon),
                          horizontalSpaceTiny,
                          Text(
                            'Original Audio - ',
                            style: appTheme.headlineSmall?.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
                Column(
                  children: [
                    UserProfileImage(
                        profileUrl: data.isRight ? data.right.profileUrl : ''),
                    verticalSpaceMedium,
                    ScaleTransition(
                      scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                              parent: _controller, curve: Curves.easeOut)),
                      child: IconButton(
                        iconSize: 34,
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                          if (isLiked) {
                            setState(() {
                              likeCount++;
                            });
                          } else {
                            setState(() {
                              likeCount--;
                            });
                          }
                        },
                        icon: isLiked
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border_sharp,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    Text("$likeCount", style: appTheme.displaySmall),
                    const SizedBox(height: 20),
                    IconButton(
                      iconSize: 34,
                      icon: SvgPicture.asset(
                        SvgPaths.commentIcon,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (ctx) => CommentBottomSheet(
                                  postId: widget.item.postId,
                                ));
                      },
                    ),
                    Text(NumbersToShort.convertNumToShort(0),
                        style: appTheme.displaySmall),
                    const SizedBox(height: 20),
                    IconButton(
                      iconSize: 34,
                      icon: SvgPicture.asset(SvgPaths.shareIcon),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                    Text("Share", style: appTheme.displaySmall),
                    const SizedBox(height: 20),
                    IconButton(
                      iconSize: 50,
                      icon: SvgPicture.asset(SvgPaths.discIcon),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return const HomePageShimmer();
      },
    );
  }
}
