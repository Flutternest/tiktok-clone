import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/post/modal/post.dart';
import 'package:tiktokclone/feature/search/respositary/search_repositary.dart';

final searchReelProvider =
    FutureProvider.family<Either<Failure, List<Post>>, String>(
        (ref, input) async {
  final findReel = await ref.read(searchProvider).findVideo(input);
  return findReel;
});
