import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/search/respositary/search_repositary.dart';

final searchUserProvider =FutureProvider.family<Either<Failure, List<UserData>>, String>((ref, userName) async {
final users = await ref.read(searchProvider).findUser(userName);
  return users;
});
