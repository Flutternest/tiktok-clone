import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/feature/home/modals/reel_model.dart';
import 'package:tiktokclone/feature/home/widgets/reels_page.dart';
import 'package:tiktokclone/feature/post/modal/post.dart';

class ReelsViewer extends StatefulWidget {
  /// use reel model and provide list of reels, list contains reels object, object contains url and other parameters
  final List<Post> reelsList;

  /// use to show/hide verified tick, by default true
  final bool showVerifiedTick;

  /// function invoke when user click on share btn and return reel url
  final Function(String)? onShare;

  /// function invoke when user click on like btn and return reel url
  final Function(String)? onLike;

  /// function invoke when user click on comment btn and return reel comment
  final Function(String)? onComment;

  /// function invoke when reel change and return current index
  final Function(int)? onIndexChanged;

  /// function invoke when user click on more options btn
  final Function()? onClickMoreBtn;

  /// function invoke when user click on follow btn
  final Function()? onFollow;

  /// for change appbar title
  final String? appbarTitle;

  /// for show/hide appbar, by default true
  final bool showAppbar;

  /// for show/hide video progress indicator, by default true
  final bool showProgressIndicator;

  /// function invoke when user click on back btn
  final Function()? onClickBackArrow;

  const ReelsViewer({
    Key? key,
    required this.reelsList,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.appbarTitle,
    this.showAppbar = true,
    this.onClickBackArrow,
    this.onIndexChanged,
    this.showProgressIndicator = true,
  }) : super(key: key);

  @override
  State<ReelsViewer> createState() => _ReelsViewerState();
}

class _ReelsViewerState extends State<ReelsViewer> {
  SwiperController controller = SwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ReelsPage(
                  item: widget.reelsList[index],
                  onClickMoreBtn: widget.onClickMoreBtn,
                  onComment: widget.onComment,
                  onFollow: widget.onFollow,
                  onLike: widget.onLike,
                  onShare: widget.onShare,
                  showVerifiedTick: widget.showVerifiedTick,
                  showProgressIndicator: widget.showProgressIndicator,
                );
              },
              controller: controller,
              itemCount: widget.reelsList.length,
              scrollDirection: Axis.vertical,
              onIndexChanged: widget.onIndexChanged,
            ),
          ],
        ),
      ),
    );
  }
}
