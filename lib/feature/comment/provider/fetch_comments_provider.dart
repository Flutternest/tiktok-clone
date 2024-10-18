import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/comment/modal/reel_comment_model.dart';
import 'package:tiktokclone/feature/comment/repositary/comment_repositary.dart';

final fetchCommentsProvider =FutureProvider.family<Either<Failure, List<ReelCommentModel>>, String>(  (ref, postId) async {
  final comments =  await ref.read(commentRespositaryProvider).fetchComments(postId: postId);
  return comments;
});
