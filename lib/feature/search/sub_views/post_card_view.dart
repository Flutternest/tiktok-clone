import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/core/constants/constants.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/feed/shimmer/feed_shimmer.dart';
import 'package:tiktokclone/feature/search/provider/fetch_users.dart';
import 'package:tiktokclone/feature/user/provider/user_provider.dart';

class PostCardView extends ConsumerStatefulWidget {
  const PostCardView(
      {super.key,
      required this.description,
      required this.thumbnailUrl,
      required this.numberOfLikes,
      required this.createdBy});
  final String description;
  final String thumbnailUrl;
  final String numberOfLikes;
  final String createdBy;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostCardViewState();
}

class _PostCardViewState extends ConsumerState<PostCardView> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(fetchProfileDataProvider(widget.createdBy));
    return userData.when(
      data: (res) {
        return res.fold((left) => Text(''), (user) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  clipBehavior: Clip.antiAlias,
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x07000000),
                        blurRadius: 15,
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Image(
                    image: NetworkImage(widget.thumbnailUrl),
                    fit: BoxFit.fill,
                  )),
              Text(
                widget.description,
                maxLines: 2,
                style: appTheme.displaySmall?.copyWith(
                  height: 1.6,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  user.profileUrl.isEmpty
                      ? SizedBox(
                          height: 29,
                          width: 29,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              AppPaths.humanImage,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 29,
                          width: 29,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                user.profileUrl,
                              )),
                        ),
                  horizontalSpaceTiny,
                  Expanded(
                    child: Text(
                      "${user.firstName} ${user.lastName}",
                      maxLines: 2,
                      style: appTheme.headlineSmall?.copyWith(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  horizontalSpaceTiny,
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 20,
                  ),
                  Text(
                    widget.numberOfLikes,
                    style: appTheme.headlineSmall?.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          );
        });
      },
      error: (Object error, StackTrace stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return FeedShimmer();
      },
    );
  }
}
