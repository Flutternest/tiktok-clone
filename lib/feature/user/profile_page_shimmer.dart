import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class ProfilePageShimmer extends StatelessWidget {
  const ProfilePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: CommonPadding(
          child: Column(
            children: [
              verticalSpaceMedium,
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
              ),
              verticalSpaceMedium,
              Container(
                width: 70,
                height: 10,
                color: Colors.white,
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50,
                    height: 20,
                    color: Colors.white,
                  ),
                  Container(
                    width: 50,
                    height: 20,
                    color: Colors.white,
                  ),
                  Container(
                    width: 50,
                    height: 20,
                    color: Colors.white,
                  )
                ],
              ),
              verticalSpaceLarge,
              verticalSpaceLarge,
            ],
          ),
        ));
  }
}
