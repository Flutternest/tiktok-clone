import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:precached_network_image/precached_network_image.dart';
import 'package:tiktokclone/core/constants/paths.dart';
import 'package:tiktokclone/feature/home/components/like_icon.dart';
import 'package:tiktokclone/feature/home/components/screen_options.dart';

import 'package:tiktokclone/feature/feed/modal/feed.dart';
import 'package:video_player/video_player.dart';

class TikTokVideosPage extends StatefulWidget {
  final Feed item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final bool showProgressIndicator;
  const TikTokVideosPage({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.showProgressIndicator = true,
    wd,
  }) : super(key: key);
  @override
  State<TikTokVideosPage> createState() => _TikTokVideosPageState();
}

class _TikTokVideosPageState extends State<TikTokVideosPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  bool isLaoding = false;

  // initialize player
  Future initializePlayer() async {
    await inializeVideoPlayerController();
    await Future.wait([_videoPlayerController!.initialize()]);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        showControls: false,
        looping: true,
        aspectRatio: MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height,
        allowFullScreen: true);
    setState(() {});
  }

  Future<void> inializeVideoPlayerController() async {
    // check file if exist than video come from cache manager.
    final checkFileExistInCache =
        await DefaultCacheManager().getFileFromCache(widget.item.videoUrl);
    if (checkFileExistInCache == null) {
      // if video don't exist in cache manager, than play form internet.
      final file3 = DefaultCacheManager().getSingleFile(widget.item.videoUrl);
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.item.videoUrl));
    } else {
      // play video from caache manager if video exist in cache manager.
      final file3 =
          await DefaultCacheManager().getSingleFile(widget.item.videoUrl);
      _videoPlayerController = VideoPlayerController.file(file3);
    }
  }

// getting the cache video from cache manager
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
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? FittedBox(
                clipBehavior: Clip.antiAlias,
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
                url: widget.item.thumbNailUrl,
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
          createdBy: widget.item.postedBy,
        )
      ],
    );
  }
}
