import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: CommonPadding(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                    horizontalSpaceTiny,
                    Container(
                      color: Colors.grey,
                      height: 12,
                      width: 150,
                    ),
                  ],
                ),
                verticalSpaceSmall,
                Container(
                  color: Colors.grey,
                  height: 12,
                  width: 150,
                ),
                verticalSpaceSmall,
                Container(
                  color: Colors.grey,
                  height: 12,
                  width: 150,
                ),
              ],
            ),
          )),
    ));
  }
}
