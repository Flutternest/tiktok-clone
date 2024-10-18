import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/auth/model/apple_login_detail.dart';
import 'package:tiktokclone/feature/auth/model/user.dart';
import 'package:tiktokclone/feature/user/user_provider/user_repositary.dart';
import 'package:uuid/uuid.dart';

class FirebaseUserRepositary implements UserRepositary {
  FirebaseUserRepositary(
      {required this.auth,
      required this.firestore,
      required this.firebaseStorage});
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  final Uuid uuid = Uuid();
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

  Future<Either<Failure, String>> uploadPicOnFirebaseStorage(
      XFile xfile) async {
    try {
      final uploadTask = await firebaseStorage
          .ref('profilePics')
          .child(uuid.v4())
          .putFile(File(xfile.path));
      final downloadUrl = await (uploadTask).ref.getDownloadURL();
      return Right(downloadUrl);
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  @override
  Future<Either<Failure, void>> changeProfilePic(
      String uid, XFile? xFile) async {
    try {
      final downloadableUrl = await uploadPicOnFirebaseStorage(xFile!);
      firestore.collection('users_data').doc(uid).update({
        'profileUrl': downloadableUrl.right,
      });
      return Right(downloadableUrl.right);
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }
    Future<void> savedataOnFirebase(UserData userData) async {
    final firstName = AppUtils.extractFirstName(userData.firstName);
    final userName = AppUtils.generateUsername(firstName);
    await firestore
        .collection('users_data')
        .doc(userData.uid)
        .set(userData.toMap());
  }
  Future<AppleLoginDetails?> fetchAppleCredentailFromFirebase(
      String tokenId) async {
    final data =
        await firestore.collection('apple_login_details').doc(tokenId).get();
    if (data.exists) {
      try {
        final appleData = await firestore
            .collection('apple_login_details')
            .doc(tokenId)
            .get();
        final data = AppleLoginDetails.fromMap(appleData.data()!);
        return data;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Future<void> saveAppleLoginDetails(AppleLoginDetails appleDetails) async {
    await firestore
        .collection('apple_login_details')
        .doc(appleDetails.token)
        .set(appleDetails.toMap());
  }
   /// Does nothing if user is not new.
  Future<void> saveNewUserOnFirebase({required UserCredential userCred}) async {
    if (userCred.additionalUserInfo?.isNewUser ?? false) {
      print(auth.currentUser!.displayName);
      final firstName = AppUtils.extractFirstName(userCred.user!.displayName!);
      final lastName = AppUtils.extractLastName(userCred.user!.displayName!);
      final userName = AppUtils.generateUsername(firstName);
      UserData userData = UserData(
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        uid: userCred.user!.uid,
        createdTime: DateTime.now(),
        email: userCred.user!.email!,
        bio: '',
        profileUrl: '',
      );
      await firestore
          .collection('users_data')
          .doc(userData.uid)
          .set(userData.toMap());
      print(userData);
    }
  }
 
}
