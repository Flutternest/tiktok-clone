import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/auth/provider/auth_provider.dart';
import 'package:tiktokclone/feature/user/user_provider/firebase_user_repositary.dart';

final userRepositaryProvider = Provider<UserRepositary>((ref) {
  return FirebaseUserRepositary(
      auth: ref.watch(firebaseAuthProvider),
      firestore: ref.watch(firestoreprovider),
      firebaseStorage: ref.watch(firebaseStorageProvider));
});

abstract class UserRepositary {
  Future<Either<Failure, UserData>> userProfiledata(String uid);
  Future<Either<Failure, void>> changeNameInUserProfile(String uid, String firstName, String lastName);
  Future<Either<Failure, List<UserData>>> fetchAllUsers();
  Future<Either<Failure, void>> changeBio(String uid, String bio);
  // Future<Either<Failure, void>> changeProfilePic(String uid, XFile? xFile);
}
