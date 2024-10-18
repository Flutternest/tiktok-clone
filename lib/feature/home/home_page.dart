import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/home/shimmer/home_page_shimmer.dart';
import 'package:tiktokclone/feature/home/widgets/tiktok_video_viewer.dart';
import 'package:tiktokclone/feature/feed/provider/feed_provider.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tiktokVideos = ref.watch(tikTokVideosProvider);
    return SafeArea(
      child: Scaffold(
        body: tiktokVideos.when(
            data: (tikTolVideosList) => TikTokVideosViewer(
                  onComment: (value) {},
                  reelsList: tikTolVideosList,
                  showVerifiedTick: false,
                ),
            error: (e, st) => Text(e.toString()),
            loading: () => const HomePageShimmer()),
      ),
    );
  }
}
