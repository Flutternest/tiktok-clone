import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/auth/repositary/auth_repositary.dart';

class FirebaseAuthRepositary implements AuthRepositary {
  FirebaseAuthRepositary({required this.auth, required this.firestore});
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  // @override
  // Future<void> appleSignIn() {
  //   // TODO: implement appleSignIn
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, UserCredential>> googleSignIn() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication googleAuth =  await googleUser!.authentication;
  //   final credential = GoogleAuthProvider.credential(  accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,);
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

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
      final userCredentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredentials.user != null) {
        final userName = await createUserName(firstName);
        UserData userData = UserData(
            firstName: firstName,
            lastName: lastName,
            userName: userName ?? '',
            uid: userCredentials.user!.uid,
            createdTime: DateTime.now(),
            email: email,
            bio: '',
            profileUrl: '');

        await saveUserDataOnFirebase(userData: userData);
        return Right(userCredentials);
      }
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

  Future<void> saveUserDataOnFirebase({required UserData userData}) async {
    await firestore
        .collection('users_data')
        .doc(userData.uid)
        .set(userData.toMap());
  }

  Future<String?> createUserName(String firstName) async {
    String username = AppUtils.generateUsername(firstName);
    if (await isUsernameAvailable(username)) {
      return username;
    }
    await createUserName(firstName);
  }

  Future<bool> isUsernameAvailable(String username) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users_data')
        .where('user_name', isEqualTo: username)
        .get();
    return query.docs.isEmpty;
  }
}
