import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/post/modal/post.dart';
import 'package:tiktokclone/feature/post/repositary/post_repositary.dart';

final fetchreelsProvider =
    FutureProvider<Either<Failure, List<Post>>>((ref) async {
  final response = await ref.read(postRepositaryProvider).fetchReels();
  return response;
});
