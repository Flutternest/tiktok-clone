import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/core/router/app_router.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/home/home_page.dart';
import 'package:tiktokclone/feature/inbox/inbox.dart';
import 'package:tiktokclone/feature/post/creating_post.dart';
import 'package:tiktokclone/feature/post/video_editor.dart';
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
          Container(
            height: 70,
            child: Row(children: [
              Expanded(
                child: InkWell(
                  radius: 100,
                  splashColor: Colors.pink[100],
                  onTap: () => _onItemTapped(0),
                  key: _itemKeys[0],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgPaths.home,
                        color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Home',
                        style: appTheme.displaySmall?.copyWith(
                            color: _selectedIndex == 3
                                ? Colors.black
                                : Colors.grey.shade700,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.pink[100],
                  onTap: () => _onItemTapped(1),
                  key: _itemKeys[1],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgPaths.searchIcon,
                        color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Discover',
                        style: appTheme.displaySmall?.copyWith(
                            color: _selectedIndex == 1
                                ? Colors.black
                                : Colors.grey.shade700,
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final xfile = await AppUtils.videoPickerFromCamera();
                    context.router.push(CreatingPostRoute(xfile: xfile!));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(40)),
                      child: SvgPicture.asset(SvgPaths.addPostIcon)),
                ),
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.pink[100],
                  onTap: () => _onItemTapped(2),
                  key: _itemKeys[2],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          SvgPaths.inbox,
                          color:
                              _selectedIndex == 2 ? Colors.black : Colors.grey,
                        ),
                        verticalSpaceTiny,
                        Text(
                          'Inbox',
                          style: appTheme.displaySmall?.copyWith(
                              color: _selectedIndex == 2
                                  ? Colors.black
                                  : Colors.grey.shade700,
                              fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.pink[100],
                  onTap: () => _onItemTapped(3),
                  key: _itemKeys[3],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgPaths.accountIcon,
                        color: _selectedIndex == 3 ? Colors.black : Colors.grey,
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Me',
                        style: appTheme.displaySmall?.copyWith(
                            color: _selectedIndex == 3
                                ? Colors.black
                                : Colors.grey.shade700,
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
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
