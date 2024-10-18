import 'package:auto_route/auto_route.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/router/app_router.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/user/profile_page_shimmer.dart';
import 'package:tiktokclone/feature/user/provider/user_provider.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, required this.uid});
  final String uid;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(fetchProfileDataProvider(widget.uid));
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: const [
                SizedBox(
                  width: 50,
                )
              ],
              leading: Center(
                child: SizedBox(
                    height: 22,
                    width: 22,
                    child: SvgPicture.asset(SvgPaths.addAcoountIcon)),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'pawan ',
                    style: appTheme.headlineSmall
                        ?.copyWith(color: Colors.black, fontSize: 17),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  userData.when(
                    data: (user) => Column(
                      children: [
                        const Divider(
                          height: 0.5,
                          color: Colors.black,
                        ),
                        verticalSpaceRegular,
                        buildUserProfile(userProfileUrl: user.right.profileUrl),
                        verticalSpaceSmall,
                        verticalSpaceTiny,
                        Text(
                          user.isRight ? "@${user.right.userName}" : '',
                          style: appTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        verticalSpaceRegular,
                        buildUserFollowListTile(
                            following: '100',
                            followers: '99',
                            likeCount: '500'),
                        verticalSpaceRegular,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () async {
                                  context.router
                                      .push(EditProfileRoute(uid: widget.uid));
                                },
                                child: Text(
                                  'Edit Profile',
                                  style: appTheme.headlineMedium?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                )),
                            horizontalSpaceTiny,
                            OutlinedButton(
                                onPressed: () {},
                                child: const Icon(
                                  Icons.bookmark_border,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                        verticalSpaceRegular,
                        Text(
                          'Tap to add bio',
                          style: appTheme.headlineMedium
                              ?.copyWith(fontSize: 14, color: Colors.grey),
                        ),
                        verticalSpaceRegular,
                      ],
                    ),
                    error: (Object error, StackTrace stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () {
                      return ProfilePageShimmer();
                    },
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  buildTabBar(),
                  buildTabView(ref: ref, uid: widget.uid),
                ],
              ),
            )));
  }

  Center buildUserProfile({required String userProfileUrl}) {
    return Center(
      child: Container(
          clipBehavior: Clip.antiAlias,
          width: 96,
          height: 96,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(userProfileUrl),
          )),
    );
  }

  Row buildUserFollowListTile(
      {required String following,
      required String followers,
      required String likeCount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              following,
              style: appTheme.headlineSmall?.copyWith(fontSize: 17),
            ),
            verticalSpaceTiny,
            Text(
              'Following',
              style: appTheme.headlineSmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff86878B)),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Text(
                followers,
                style: appTheme.headlineSmall?.copyWith(fontSize: 17),
              ),
              verticalSpaceTiny,
              Text(
                'Followers',
                style: appTheme.headlineSmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff86878B)),
              )
            ],
          ),
        ),
        Column(
          children: [
            Text(
              likeCount,
              style: appTheme.headlineSmall?.copyWith(fontSize: 17),
            ),
            verticalSpaceTiny,
            Text(
              'like',
              style: appTheme.headlineSmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff86878B)),
            )
          ],
        ),
      ],
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      indicatorColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      onTap: (value) {},
      tabs: [
        Tab(
          icon: SizedBox(width: 60, child: SvgPicture.asset(SvgPaths.tabsIcon)),
        ),
        Tab(
          icon: SizedBox(
            width: 60,
            child: SvgPicture.asset(
              SvgPaths.heartbrokenIcon,
            ),
          ),
        ),
      ],
    );
  }

  Expanded buildTabView({required WidgetRef ref, required String uid}) {
    final userReels = ref.watch(fetchReelsofUserProvider(uid));
    return Expanded(
      child: TabBarView(children: [
        userReels.when(
          data: (reel) => Tab(
            child: DynamicHeightGridView(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              builder: (BuildContext context, int index) {
                return Container(
                  height: 182,
                  child: Image(
                    image: NetworkImage(reel.right[index].thumbNailUrl),
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: reel.right.length,
              crossAxisCount: 3,
            ),
          ),
          error: (Object error, StackTrace stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        Tab(
          child: DynamicHeightGridView(
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            builder: (BuildContext context, int index) {
              return Container(
                height: 182,
                child: const Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-vector/cloud-network-system-background-social-media-post_53876-119487.jpg?w=1380&t=st=1707911499~exp=1707912099~hmac=615a926217d9ef59748896d208444cc74debc02ff6c6827a8106a135ffeb5986',
                  ),
                  fit: BoxFit.fill,
                ),
              );
            },
            itemCount: 10,
            crossAxisCount: 3,
          ),
        ),
      ]),
    );
  }
}
