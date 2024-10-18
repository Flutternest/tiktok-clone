import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/feed/modal/feed.dart';
import 'package:tiktokclone/feature/search/respositary/search_repositary.dart';

class FirbaseSearchRepositary extends SearchRepositary {
  FirbaseSearchRepositary({required this.firebaseFirestore});
  final FirebaseFirestore firebaseFirestore;
  @override
  Future<Either<Failure, List<Feed>>> findVideo(String videoDescription) async {
    try {
      final posts = await firebaseFirestore
          .collection('reels')
          .where('description', isGreaterThanOrEqualTo: videoDescription)
          .get();
      final reels = posts.docs.map((e) => Feed.fromMap(e.data())).toList();
      return Right(reels);
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  Future<Either<Failure, List<UserData>>> findUser(String userName) async {
    try {
      final usersDoceument = await firebaseFirestore
          .collection('users_data')
          .where('userName', isGreaterThanOrEqualTo: userName)
          .get();
      final users =
          usersDoceument.docs.map((e) => UserData.fromMap(e.data())).toList();
      return Right(users);
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }
}
