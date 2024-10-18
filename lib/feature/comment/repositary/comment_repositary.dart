import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/provider/auth_provider.dart';
import 'package:tiktokclone/feature/comment/modal/reel_comment_model.dart';
import 'package:tiktokclone/feature/comment/repositary/firebase_comment_repositary.dart';

final commentRespositaryProvider = Provider<CommentRepoitary>((ref) {
  return FirebaseCommentRepositary(
      firebaseFirestore: ref.watch(firestoreprovider));
});

abstract class CommentRepoitary {
  Future<Either<Failure, void>> doComment(
      {required ReelCommentModel commentModel});
  Future<Either<Failure, List<ReelCommentModel>>> fetchComments(
      {required String postId});
}
