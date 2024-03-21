import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/provider/auth_provider.dart';
import 'package:tiktokclone/feature/post/modal/post.dart';
import 'package:tiktokclone/feature/post/repositary/firebase_post_repositary.dart';

final postRepositaryProvider = Provider<PostRepositary>((ref) {
  return FirebasePostRepositary(
      firebaseStorage: ref.watch(firebaseStorageProvider),
      auth: ref.watch(firebaseAuthProvider),
      firestore: ref.watch(firestoreprovider));
});

abstract class PostRepositary {
  Future<Either<Failure, void>> addPost(String path, String description, String postId);
  Future<Either<Failure, List<Post>>> fetchReels();
  Future<Either<Failure, List<Post>>> fetchReelsOfUser(String uid);
}
