import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class SearchUserShimmer extends StatelessWidget {
  const SearchUserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: ListView.builder(itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                    horizontalSpaceSmall,
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 10,
                          color: Colors.white,
                        ),
                        verticalSpaceTiny,
                        Container(
                          width: 70,
                          height: 10,
                          color: Colors.white,
                        ),
                        verticalSpaceTiny,
                        Container(
                          width: 70,
                          height: 10,
                          color: Colors.white,
                        ),
                        verticalSpaceTiny,
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 50,
                  height: 25,
                  color: Colors.white,
                )
              ],
            );
          })),
    ));
  }
}
