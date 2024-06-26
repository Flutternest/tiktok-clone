import 'package:auto_route/auto_route.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/core/constants/constants.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';
import 'package:tiktokclone/feature/global_widgets/userlisttile.dart';
import 'package:tiktokclone/feature/home/widgets/reels_page.dart';
import 'package:tiktokclone/feature/home/widgets/reels_page_one_video.dart';
import 'package:tiktokclone/feature/post/provider/post_provider.dart';
import 'package:tiktokclone/feature/search/provider/fetch_users.dart';
import 'package:tiktokclone/feature/search/provider/search_reel_provider.dart';
import 'package:tiktokclone/feature/search/provider/search_user_provider.dart';
import 'package:tiktokclone/feature/search/shimmer/search_reel_shimmer.dart';
import 'package:tiktokclone/feature/search/shimmer/search_user_shimmer.dart';
import 'package:tiktokclone/feature/search/sub_views/post_card_view.dart';

@RoutePage()
class SearchScreenPage extends ConsumerWidget {
  SearchScreenPage({super.key});
  final TextEditingController serachTextController = TextEditingController();
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reels = ref.watch(fetchreelsProvider);
    final searchReels =
        ref.watch(searchReelProvider(serachTextController.text));
    final users = ref.watch(fetchUsersProvider);
    final searchUsers =
        ref.watch(searchUserProvider(serachTextController.text));
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DefaultTabController(
          length: 2,
          child: CommonPadding(
            child: Column(children: [
              verticalSpaceSmall,
              Row(
                children: [
                  Expanded(
                      child: AppSearchBar(
                          onTap: () {
                            serachTextController.clear();
                          },
                          onChanged: (input) {
                            ref.invalidate(searchReelProvider);
                            ref.invalidate(searchUserProvider);
                          },
                          controller: serachTextController,
                          hinttext: 'search')),
                  horizontalSpaceTiny,
                  const Icon(Icons.more_horiz),
                ],
              ),
              TabBar(
                indicatorColor: Colors.black,
                onTap: (value) {},
                labelStyle: appTheme.displaySmall
                    ?.copyWith(color: Colors.black, fontSize: 17),
                labelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: "videos",
                  ),
                  Tab(
                    text: "users",
                  ),
                ],
              ),
              verticalSpaceRegular,
              Expanded(
                child: TabBarView(children: [
                  serachTextController.text.isEmpty
                      ? reels.when(
                          data: (res) {
                            return res.fold((left) => const Text(''),
                                (reelslist) {
                              return DynamicHeightGridView(
                                  builder: (context, index) {
                                    final reel = reelslist[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReelsPageOneVideoPage(
                                                        item: reel)));
                                      },
                                      child: PostCardView(
                                        description: reel.description,
                                        thumbnailUrl: reel.thumbNailUrl,
                                        numberOfLikes:
                                            "${res.right[index].numberOfLikes}",
                                        createdBy: reel.postedBy,
                                      ),
                                    );
                                  },
                                  itemCount: res.isRight ? res.right.length : 0,
                                  crossAxisCount: 2);
                            });
                          },
                          error: (Object error, StackTrace stackTrace) {
                            return Text(error.toString());
                          },
                          loading: () {
                            return const CircularProgressIndicator();
                          },
                        )
                      : searchReels.when(
                          data: (res) {
                            return res.fold((left) => const Text(''),
                                (reelslist) {
                              return DynamicHeightGridView(
                                  builder: (context, index) {
                                    final reel = reelslist[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReelsPageOneVideoPage(
                                                        item: reel)));
                                      },
                                      child: PostCardView(
                                        description: reel.description,
                                        thumbnailUrl: reel.thumbNailUrl,
                                        numberOfLikes:
                                            "${res.right[index].numberOfLikes}",
                                        createdBy: reel.postedBy,
                                      ),
                                    );
                                  },
                                  itemCount: res.isRight ? res.right.length : 0,
                                  crossAxisCount: 2);
                            });
                          },
                          error: (Object error, StackTrace stackTrace) {
                            return Text(error.toString());
                          },
                          loading: () {
                            return const SearchReelShimmer();
                          },
                        ),
                  serachTextController.text.isEmpty
                      ? users.when(
                          data: (res) {
                            return res.fold((left) => const Text(''), (user) {
                              return ListView.builder(
                                  itemCount: user.length,
                                  itemBuilder: (context, index) {
                                    return UserListTile(
                                      userName: user[index].userName,
                                      firstname: user[index].firstName,
                                      lastName: user[index].lastName,
                                      userProfileImage: user[index].profileUrl,
                                    );
                                  });
                            });
                          },
                          error: (e, st) => Text(e.toString()),
                          loading: () => const CircularProgressIndicator())
                      : searchUsers.when(
                          data: (res) {
                            return res.fold((left) => const Text(''), (user) {
                              return ListView.builder(
                                  itemCount: user.length,
                                  itemBuilder: (context, index) {
                                    return UserListTile(
                                      userName: user[index].userName,
                                      firstname: user[index].firstName,
                                      lastName: user[index].lastName,
                                      userProfileImage: user[index].profileUrl,
                                    );
                                  });
                            });
                          },
                          error: (e, st) => Text(e.toString()),
                          loading: () => const SearchUserShimmer()),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.hinttext,
    this.onChanged,
    this.controller,
    this.onTap,
  });
  final String hinttext;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          focusColor: null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintText: hinttext,
          hintStyle: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: const Color(0xFFBDBDBD), fontSize: 15),
          prefixIcon: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              )),
          suffixIcon: controller!.text.isEmpty
              ? const SizedBox()
              : InkWell(
                  onTap: onTap,
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.black54,
                  ),
                ),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
