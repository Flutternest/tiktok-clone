import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/feed/modal/feed.dart';
import 'package:tiktokclone/feature/feed/repositary/feed_repositary.dart';

final tikTokVideosProvider = FutureProvider<List<Feed>>((ref) async {
  final response = await ref.read(tikTokRepositaryProvider).fetchTikTokVideos();
  return response.fold((l) => throw l, (tikTokVideos) {
    return tikTokVideos;
  });
});
