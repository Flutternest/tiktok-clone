import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/home/widgets/reels_page.dart';
import 'package:tiktokclone/feature/post/modal/post.dart';

class ReelsPageOneVideoPage extends ConsumerStatefulWidget {
  const ReelsPageOneVideoPage({super.key, required this.item});
  final Post item;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReelsPageOneVideoPageState();
}

class _ReelsPageOneVideoPageState extends ConsumerState<ReelsPageOneVideoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: ReelsPage(item: widget.item)));
  }
}
