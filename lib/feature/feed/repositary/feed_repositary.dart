import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/provider/auth_provider.dart';
import 'package:tiktokclone/feature/feed/modal/feed.dart';
import 'package:tiktokclone/feature/feed/repositary/firebase_feed_repositary.dart';

final tikTokRepositaryProvider = Provider<TikTokVideoRepository>((ref) {
  return FirebaseTikTokVideosRepository(
      firebaseStorage: ref.watch(firebaseStorageProvider),
      auth: ref.watch(firebaseAuthProvider),
      firestore: ref.watch(firestoreprovider));
});

abstract class TikTokVideoRepository {
  Future<Either<Failure, void>> addTikTokVideo(
      String path, String description, String postId);
  Future<Either<Failure, List<Feed>>> fetchTikTokVideos();
  Future<Either<Failure, List<Feed>>> fetcTikTokVideoOfUser(String uid);
}
