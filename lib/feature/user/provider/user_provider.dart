import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/post/modal/post.dart';
import 'package:tiktokclone/feature/post/repositary/post_repositary.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';

final fetchProfileDataProvider =
    FutureProvider.family<Either<Failure, UserData>, String>((ref, uid) async {
  final userData = await ref.read(userRepositaryProvider).userProfiledata(uid);
  return userData;
});

final fetchReelsofUserProvider =  
    FutureProvider.family<Either<Failure, List<Post>>, String>(
        (ref, uid) async {
  final userReels = ref.read(postRepositaryProvider).fetchReelsOfUser(uid);
  return userReels;
});
