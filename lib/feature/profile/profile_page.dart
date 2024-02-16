import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
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
                    'Jacob West',
                    style: appTheme.headlineSmall
                        ?.copyWith(color: Colors.black, fontSize: 17),
                  ),
                  Icon(
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
                  const Divider(
                    height: 0.5,
                    color: Colors.black,
                  ),
                  verticalSpaceRegular,
                  Center(
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: 96,
                        height: 96,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-vector/cloud-network-system-background-social-media-post_53876-119487.jpg?w=1380&t=st=1707911499~exp=1707912099~hmac=615a926217d9ef59748896d208444cc74debc02ff6c6827a8106a135ffeb5986'),
                        )),
                  ),
                  verticalSpaceSmall,
                  verticalSpaceTiny,
                  Text(
                    '@username',
                    style: appTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  verticalSpaceRegular,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '14',
                            style:
                                appTheme.headlineSmall?.copyWith(fontSize: 17),
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
                      Column(
                        children: [
                          Text(
                            '14',
                            style:
                                appTheme.headlineSmall?.copyWith(fontSize: 17),
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
                      Column(
                        children: [
                          Text(
                            '14',
                            style:
                                appTheme.headlineSmall?.copyWith(fontSize: 17),
                          ),
                          verticalSpaceTiny,
                          Text(
                            'like',
                            style: appTheme.headlineSmall?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff86878B)),
                          )
                        ],
                      ),
                    ],
                  ),
                  verticalSpaceRegular,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/editProfilePage');
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
                    'Tap to add Bio',
                    style: appTheme.headlineMedium
                        ?.copyWith(fontSize: 14, color: Colors.grey),
                  ),
                  verticalSpaceRegular,
                  const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  TabBar(
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (value) {},
                    tabs: [
                      Tab(
                        icon: SizedBox(
                            width: 60,
                            child: SvgPicture.asset(SvgPaths.tabsIcon)),
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
                  ),
                  Expanded(
                    child: TabBarView(children: [
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
                  )
                ],
              ),
            )));
  }
}
