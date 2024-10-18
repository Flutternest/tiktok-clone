import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class CommentShimmer extends StatelessWidget {
  const CommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: CommonPadding(
            child: Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      verticalSpaceMedium,
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                          horizontalSpaceSmall,
                          Container(
                            width: 100,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.rectangle),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                    ],
                  );
                },
              ),
            ),
          )),
    ));
  }
}
