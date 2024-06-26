import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x07000000),
                      blurRadius: 15,
                      offset: Offset(0, 3),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
              verticalSpaceSmall,
              Container(
                width: double.infinity,
                height: 12,
                color: Colors.white,
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      horizontalSpaceTiny,
                      Container(
                        width: 50,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    width: 20,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          )),
    ));
  }
}
