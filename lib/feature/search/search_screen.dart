import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/core/constants/constants.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';
import 'package:tiktokclone/feature/global_widgets/userlisttile.dart';
import 'package:tiktokclone/feature/search/sub_views/post_card_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      color: Colors.black,
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  horizontalSpaceTiny,
                  Expanded(child: AppSearchBar(hinttext: 'search')),
                  horizontalSpaceTiny,
                  Icon(Icons.more_horiz),
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
                  DynamicHeightGridView(
                      builder: (context, index) => PostCardView(),
                      itemCount: 10,
                      crossAxisCount: 2),
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => UserListTile()),
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
  });
  final String hinttext;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

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
          prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              )),
          suffixIcon: Icon(
            Icons.cancel,
            color: Colors.black54,
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
