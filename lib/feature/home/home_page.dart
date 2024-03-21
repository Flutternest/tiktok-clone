import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/home/shimmer/home_page_shimmer.dart';
import 'package:tiktokclone/feature/home/widgets/reels_viewer.dart';
import 'package:tiktokclone/feature/post/provider/post_provider.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is paused (backgrounded)
      print('App is paused');
    } else if (state == AppLifecycleState.resumed) {
      // App is resumed (foregrounded)
      print('App is resumed');
    } else if (state == AppLifecycleState.inactive) {
      // App is inactive
      print('App is inactive');
    } else if (state == AppLifecycleState.detached) {
      // App is terminated
      print('App is terminated');
    }
  }

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
    final reels = ref.watch(fetchreelsProvider);
    return SafeArea(
      child: Scaffold(
        body: reels.when(
            data: (data) => ReelsViewer(
                  onComment: (value) {},
                  reelsList: data.isRight ? data.right : [],
                  showVerifiedTick: false,
                ),
            error: (e, st) => Text(e.toString()),
            loading: () => const HomePageShimmer()),
      ),
    );
  }
}
