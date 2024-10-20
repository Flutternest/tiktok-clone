import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/provider/auth_provider.dart';
import 'package:tiktokclone/feature/auth/repositary/firebase_auth_repositary.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(
      auth: ref.watch(firebaseAuthProvider), ref: ref);
});

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password});
  Future<Either<Failure, UserCredential>> signIn(
      {required String email, required String password});
  Future<Either<Failure, UserCredential>> googleSignIn();
  Future<Either<Failure, UserCredential>> appleSignIn();
  Future<void> signOut();
}
