import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tiktokclone/feature/home/modals/reel_comment_model.dart';
import 'package:tiktokclone/feature/home/modals/reel_model.dart';
import 'package:tiktokclone/feature/home/widgets/reels_viewer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<ReelModel> reelsList = [
    ReelModel(
        'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
        'Darshan Patil',
        likeCount: 2000,
        isLiked: true,
        musicName: 'In the name of Love',
        reelDescription: "Life is better when you're laughing.",
        profileUrl:
            'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
        commentList: [
          ReelCommentModel(
            comment: 'Nice...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
          ReelCommentModel(
            comment: 'Superr...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
          ReelCommentModel(
            comment: 'Great...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
        ]),
    ReelModel(
      'https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4',
      'Rahul',
      musicName: 'In the name of Love',
      reelDescription: "Life is better when you're laughing.",
      profileUrl:
          'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
    ),
    ReelModel(
      'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
      'Rahul',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ReelsViewer(
        reelsList: reelsList,
        onShare: (url) {
          log('Shared reel url ==> $url');
        },
        onLike: (url) {
          log('Liked reel url ==> $url');
        },
        onFollow: () {
          log('======> Clicked on follow <======');
        },
        onComment: (comment) {
          log('Comment on reel ==> $comment');
        },
        onClickMoreBtn: () {
          log('======> Clicked on more option <======');
        },
        onClickBackArrow: () {
          log('======> Clicked on back arrow <======');
        },
        onIndexChanged: (index) {
          log('======> Current Index ======> $index <========');
        },
        showProgressIndicator: true,
        showVerifiedTick: false,
      ),
    ));
  }
}
