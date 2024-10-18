import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/feed/modal/feed.dart';
import 'package:tiktokclone/feature/feed/repositary/feed_repositary.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';

final fetchProfileDataProvider =
    FutureProvider.family<Either<Failure, UserData>, String>((ref, uid) async {
  final userData = await ref.read(userRepositaryProvider).userProfiledata(uid);
  return userData;
});

final fetchReelsofUserProvider =
    FutureProvider.family<Either<Failure, List<Feed>>, String>(
        (ref, uid) async {
  final userReels =
      ref.read(tikTokRepositaryProvider).fetcTikTokVideoOfUser(uid);
  return userReels;
});
