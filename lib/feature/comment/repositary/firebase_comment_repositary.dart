import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/comment/modal/reel_comment_model.dart';
import 'package:tiktokclone/feature/comment/repositary/comment_repositary.dart';

class FirebaseCommentRepositary implements CommentRepoitary {
  FirebaseCommentRepositary({required this.firebaseFirestore});
  final FirebaseFirestore firebaseFirestore;
  @override
  Future<Either<Failure, void>> doComment({required ReelCommentModel commentModel}) async {
    try {
      firebaseFirestore.collection('reels').doc(commentModel.postId).collection('comments').doc(commentModel.commentId).set(commentModel.toMap());
      return Right('');
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  @override
  Future<Either<Failure, List<ReelCommentModel>>> fetchComments(
      {required String postId}) async {
    try {
      final commentDocuments = await firebaseFirestore
          .collection('reels')
          .doc(postId)
          .collection('comments')
          .orderBy('commentTime', descending: true)
          .get();
      final comments = commentDocuments.docs
          .map((e) => ReelCommentModel.fromMap(e.data()))
          .toList();
      return Right(comments);
    } catch (e) {
      print("coming error ${e.toString()}");
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }
}
