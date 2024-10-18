import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/router/app_router.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/home/home_page.dart';
import 'package:tiktokclone/feature/home/widgets/app_bottom_bar_item.dart';
import 'package:tiktokclone/feature/inbox/inbox.dart';
import 'package:tiktokclone/feature/user/profile_page.dart';
import 'package:tiktokclone/feature/search/search_screen.dart';

@RoutePage()
class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
  });
  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  PageController _pageController = PageController();
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  int _selectedIndex = 0;
  final _bucket = PageStorageBucket();

  final List<GlobalKey> _itemKeys = List.generate(
    4,
    (_) => GlobalKey(),
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      SearchScreenPage(),
      const InboxPage(),
      ProfilePage(
        uid: FirebaseAuth.instance.currentUser?.uid ?? '',
      ),
    ];

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Stack(
        children: [
          SizedBox(
            height: 70,
            child: Row(children: [
              AppBottomBarWidget(
                key: _itemKeys[0],
                onTap: () => _onItemTapped(0),
                svgPath: SvgPaths.home,
                textColor:
                    _selectedIndex == 0 ? Colors.black : Colors.grey.shade700,
                iconColor: _selectedIndex == 0 ? Colors.black : Colors.grey,
                title: 'Home',
              ),
              AppBottomBarWidget(
                key: _itemKeys[1],
                svgPath: SvgPaths.searchIcon,
                onTap: () => _onItemTapped(1),
                textColor:
                    _selectedIndex == 1 ? Colors.black : Colors.grey.shade700,
                iconColor: _selectedIndex == 1 ? Colors.black : Colors.grey,
                title: 'Discover',
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    showModalBottomSheet(
                        shape: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              verticalSpaceRegular,
                              Text(
                                "Pick Image",
                                style: appTheme.displaySmall,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final xfile = await AppUtils
                                            .videoPickerFromCamera();
                                        context.router.pop();
                                        context.router.push(
                                            CreatingPostRoute(xfile: xfile!));
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.camera,
                                              size: 50,
                                              color: Colors.pink,
                                            ),
                                            verticalSpaceSmall,
                                            Text(
                                              "Camera",
                                              style: appTheme.bodySmall,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final xfile = await AppUtils
                                            .videoPickerFromGallery();
                                        context.router.pop();
                                        context.router.push(
                                            CreatingPostRoute(xfile: xfile!));
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons
                                                  .photo_size_select_actual_outlined,
                                              size: 50,
                                              color: Colors.pink,
                                            ),
                                            verticalSpaceSmall,
                                            Text(
                                              "Gallery",
                                              style: appTheme.bodySmall,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(40)),
                      child: SvgPicture.asset(SvgPaths.addPostIcon)),
                ),
              ),
              AppBottomBarWidget(
                key: _itemKeys[2],
                onTap: () => _onItemTapped(2),
                svgPath: SvgPaths.inbox,
                textColor:
                    _selectedIndex == 2 ? Colors.black : Colors.grey.shade700,
                iconColor: _selectedIndex == 2 ? Colors.black : Colors.grey,
                title: 'Inbox',
              ),
              AppBottomBarWidget(
                key: _itemKeys[3],
                onTap: () => _onItemTapped(3),
                svgPath: SvgPaths.accountIcon,
                textColor:
                    _selectedIndex == 3 ? Colors.black : Colors.grey.shade700,
                iconColor: _selectedIndex == 3 ? Colors.black : Colors.grey,
                title: 'Me',
              ),
            ]),
          ),
        ],
      ),
      body: PageStorage(
        bucket: _bucket,
        child: pages[_selectedIndex],
      ),
    ));
  }
}
