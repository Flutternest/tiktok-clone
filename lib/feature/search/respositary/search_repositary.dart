import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/auth/provider/auth_provider.dart';
import 'package:tiktokclone/feature/post/modal/post.dart';
import 'package:tiktokclone/feature/search/respositary/firebase_search_repo.dart';

final searchProvider = Provider<SearchRepositary>((ref) {
  return FirbaseSearchRepositary(
      firebaseFirestore: ref.watch(firestoreprovider));
});

abstract class SearchRepositary {
  Future<Either<Failure, List<Post>>> findVideo(String videoDescription);
  Future<Either<Failure, List<UserData>>> findUser(String videoDescription);
}
