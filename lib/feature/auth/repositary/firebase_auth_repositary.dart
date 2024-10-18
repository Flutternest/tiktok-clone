import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/apple_login_detail.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/auth/provider/auth_provider.dart';
import 'package:tiktokclone/feature/auth/repositary/auth_repositary.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({required this.auth, required this.ref});

  final FirebaseAuth auth;
  final Ref ref;

  @override
  Future<Either<Failure, UserCredential>> signIn(
      {required String email, required String password}) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        return Right(user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return Left(
            Failure(message: 'Please enter valid email', errorCode: e.code));
      } else if (e.code == 'user-disabled') {
        return Left(Failure(message: 'User is disabled', errorCode: e.code));
      } else if (e.code == 'user-not-found') {
        return Left(Failure(message: 'User  not found', errorCode: e.code));
      } else if (e.code == 'wrong-password') {
        return Left(Failure(message: 'Wrong password', errorCode: e.code));
      } else if (e.code == 'invalid-credential') {
        return Left(Failure(
            message: 'wrong password or invalid user', errorCode: e.code));
      }
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
    return Left(Failure(message: 'Someting went wrong', errorCode: ''));
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userName = AppUtils.generateUsername(firstName);
      UserData userData = UserData(
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          uid: userCredential.user!.uid,
          createdTime: DateTime.now(),
          email: email,
          bio: '',
          profileUrl: '');
      await ref.read(userRepositaryProvider).savedataOnFirebase(userData);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left(
            Failure(message: 'Email already registered', errorCode: e.code));
      } else if (e.code == 'invalid-email') {
        return Left(
            Failure(message: 'Please enter valid email', errorCode: e.code));
      } else if (e.code == 'operation-not-allowed') {
        return Left(
            Failure(message: 'your account is disbaled', errorCode: e.code));
      } else if (e.code == 'weak-password') {
        return Left(
            Failure(message: 'Password is too weak', errorCode: e.code));
      }
    } catch (e) {
      print("error ${e.toString()}");
      return Left(Failure(message: "Something went wrong", errorCode: ""));
    }
    return Left(Failure(message: "Something went wrong", errorCode: ""));
  }

  @override
  Future<Either<Failure, UserCredential>> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return signInWithCredential(credential);
  }

  @override
  Future<Either<Failure, UserCredential>> appleSignIn() async {
    final authProvider = AppleAuthProvider();

    authProvider.addScope("email");
    authProvider.addScope("name");

    return signInWithProvider(authProvider);
  }

  /// Creates account & save user data to firebase if user is newly created (signup)
  Future<Either<Failure, UserCredential>> signInWithCredential(
      AuthCredential authCredential) async {
    try {
      final user = await auth.signInWithCredential(authCredential);
      await ref
          .read(userRepositaryProvider)
          .saveNewUserOnFirebase(userCred: user);

      return Right(user);
    } on FirebaseAuthException catch (fe) {
      return Left(Failure(
          errorCode: fe.code, message: fe.message ?? "Something went wrong"));
    } catch (e) {
      return Left(Failure(errorCode: "400", message: "Something went wrong"));
    }
  }

  /// Creates account & save user data to firebase if user is newly created (signup)
  Future<Either<Failure, UserCredential>> signInWithProvider(
      AuthProvider provider) async {
    try {
      final user = await auth.signInWithProvider(provider);
      if (user.additionalUserInfo!.isNewUser) {
        ref.read(userRepositaryProvider).saveNewUserOnFirebase(userCred: user);
      }
      return Right(user);
    } on FirebaseAuthException catch (fe) {
      if ('user-disabled' == fe.code) {
        return Left(Failure(message: 'user is disabled.', errorCode: fe.code));
      }
    } catch (e) {
      print(e.toString());
      return Left(Failure(errorCode: "400", message: e.toString()));
    }
    return Left(Failure(errorCode: "400", message: 'Something went wrong'));
  }

  Future<String?> generateUsername(String firstName) async {
    String username = AppUtils.generateUsername(firstName);
    if (await isUsernameAvailable(username)) {
      return username;
    }
    return await generateUsername(firstName);
  }

  Future<bool> isUsernameAvailable(String username) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users_data')
        .where('user_name', isEqualTo: username)
        .get();
    return query.docs.isEmpty;
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
