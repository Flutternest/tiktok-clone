
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';

class FirebaseUserRepositary implements UserRepositary {
  FirebaseUserRepositary(
      {required this.auth,
      required this.firestore,
      required this.firebaseStorage});
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  @override
  Future<Either<Failure, UserData>> userProfiledata(String uid) async {
    try {
      final data = await firestore.collection('users_data').doc(uid).get();
      final userData = UserData.fromMap(data.data()!);
      return Right(userData);
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  @override
  Future<Either<Failure, void>> changeNameInUserProfile(
      String uid, String firstName, String lastName) async {
    try {
      await firestore.collection('users_data').doc(uid).update({
        "firstName": firstName,
        "lastName": lastName,
      });
      return Right('');
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  @override
  Future<Either<Failure, List<UserData>>> fetchAllUsers() async {
    try {
      final usersDocuments = await firestore
          .collection('users_data')
          .where('uid', isNotEqualTo: auth.currentUser?.uid)
          .get();
      final users =
          usersDocuments.docs.map((e) => UserData.fromMap(e.data())).toList();
      return Right(users);
    } catch (e) {
      print(e.toString());
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  @override
  Future<Either<Failure, void>> changeBio(String uid, String bio) async {
    try {
      await firestore.collection('users_data').doc(uid).update({
        "bio": bio,
      });
      return Right('');
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  // Future<Either<Failure, String>> uploadPicOnFirebaseStorage(
  //     XFile xfile) async {
  //   try {
  //     final uploadTask = await firebaseStorage
  //         .ref()
  //         .child('profilePics')
  //         .putFile(io.File(xfile.path));
  //     final downloadUrl = await (uploadTask).ref.getDownloadURL();
  //     return Right(downloadUrl);
  //   } catch (e) {
  //     return Left(Failure(message: e.toString(), errorCode: ''));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> changeProfilePic( String uid, XFile? xFile) async {
  //   try {
  //     final downloadableUrl = await uploadPicOnFirebaseStorage(xFile!);
  //     firestore.collection('users_data').doc(uid).update({
  //       'profileUrl': downloadableUrl,
  //     });
  //     return Right(downloadableUrl.right);
  //   } catch (e) {
  //     return Left(Failure(message: e.toString(), errorCode: ''));
  //   }
  // }
}
