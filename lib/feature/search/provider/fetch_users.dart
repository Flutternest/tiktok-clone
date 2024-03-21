import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';

final fetchUsersProvider =
    FutureProvider<Either<Failure, List<UserData>>>((ref) async {
  final users = ref.read(userRepositaryProvider).fetchAllUsers();
  return users;
});
