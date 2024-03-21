import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:precached_network_image/precached_network_image.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/feature/home/components/like_icon.dart';
import 'package:tiktokclone/feature/home/components/screen_options.dart';

import 'package:tiktokclone/feature/post/modal/post.dart';
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  final Post item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final SwiperController swiperController;
  final String createdBy;
  final bool showProgressIndicator;
  final String thumbNailUrl;

  const ReelsPage(
      {Key? key,
      required this.item,
      this.showVerifiedTick = true,
      this.onClickMoreBtn,
      this.onComment,
      this.onFollow,
      this.onLike,
      this.onShare,
      this.showProgressIndicator = true,
      required this.createdBy,
      required this.swiperController,
      wd,
      required this.thumbNailUrl})
      : super(key: key);
  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  bool isLaoding = false;
  Future initializePlayer() async {
    final checkFileExistInCache =
        await DefaultCacheManager().getFileFromCache(widget.item.videoUrl);
    if (checkFileExistInCache == null) {
      final file3 = DefaultCacheManager().getSingleFile(widget.item.videoUrl);
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.item.videoUrl));
    } else {
      final file3 =
          await DefaultCacheManager().getSingleFile(widget.item.videoUrl);
      _videoPlayerController = VideoPlayerController.file(file3);
    }

    await Future.wait([_videoPlayerController!.initialize()]);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        showControls: false,
        looping: false,
        aspectRatio: MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height,
        allowFullScreen: true);
    setState(() {});
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController!.value.position ==
          _videoPlayerController!.value.duration) {
        widget.swiperController.next();
      }
    });
  }

  Future<FileInfo?> getCacheVideo(String key) async {
    final file3 = await DefaultCacheManager().getFileFromCache(key);
    return file3;
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getVideoView();
  }

  Widget getVideoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&  _chewieController!.videoPlayerController.value.isInitialized
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GestureDetector(
                    onDoubleTap: () {},
                    child: Chewie(
                      controller: _chewieController!,
                    ),
                  ),
                ),
              )
            : PrecachedNetworkImage(
                placeholder: (context, url) => const Image(
                  image: AssetImage(
                    AppPaths.blurImage,
                  ),
                  fit: BoxFit.cover,
                ),
                url: widget.thumbNailUrl,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
        if (_liked)
          const Center(
            child: LikeIcon(),
          ),
        if (widget.showProgressIndicator && _videoPlayerController != null)
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: VideoProgressIndicator(
              _videoPlayerController!,
              allowScrubbing: false,
              colors: const VideoProgressColors(
                backgroundColor: Colors.blueGrey,
                bufferedColor: Colors.blueGrey,
                playedColor: Colors.pink,
              ),
            ),
          ),
        ScreenOptions(
          onClickMoreBtn: widget.onClickMoreBtn,
          onComment: widget.onComment,
          onFollow: widget.onFollow,
          onLike: widget.onLike,
          onShare: widget.onShare,
          showVerifiedTick: widget.showVerifiedTick,
          item: widget.item,
          createdBy: widget.createdBy,
        )
      ],
    );
  }
}