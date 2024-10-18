import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktokclone/core/constants/paths.dart';

class UserProfileImage extends StatelessWidget {
  final String profileUrl;
  const UserProfileImage({Key? key, required this.profileUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(children: [
        CachedNetworkImage(
          imageUrl: profileUrl,
          alignment: Alignment.centerLeft,
          imageBuilder: (context, imageProvider) => Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Container(
            height: 38,
            width: 38,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.person),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(SvgPaths.plusIcon)),
      ]),
    );
  }
}
