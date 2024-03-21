import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/feature/auth/exception/failure.dart';
import 'package:tiktokclone/feature/post/modal/post.dart';
import 'package:tiktokclone/feature/post/repositary/post_repositary.dart';
import 'package:uuid/uuid.dart';

class FirebasePostRepositary extends PostRepositary {
  FirebasePostRepositary(
      {required this.auth,
      required this.firestore,
      required this.firebaseStorage});
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final Uuid uuid = const Uuid();
  @override
  Future<Either<Failure, void>> addPost(
      String path, String description, String postId) async {
    try {
      final response = await uploadVideoOnFirebaseStorage(path);
      final videoThumbNail = await AppUtils.getImageFromVideo(XFile(path));
      final downloadbaleVideoThumbnail = await uploadPhotoOnFirebaseStorage(videoThumbNail!);
      Post post = Post(
          videoUrl: response.right,
          postId: postId,
          postedBy: auth.currentUser!.uid,
          createdTime: DateTime.now(),
          numberOfComments: 0,
          numberOfLikes: 0,
          numberOfViews: 0,
          thumbNailUrl: downloadbaleVideoThumbnail.right,
          // thumbNailUrl: '',
          description: description);
      await firestore.collection('reels').doc(post.postId).set(post.toMap());
      return Right('');
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  Future<Either<Failure, String>> uploadVideoOnFirebaseStorage(
      String path) async {
    final ext = path.split('.').last;
    try {
      final uploadTask = await firebaseStorage
          .ref('reels')
          .child(uuid.v4())
          .putFile(File(path), SettableMetadata(contentType: 'video/$ext'));
      final downloadableUrl = await (uploadTask).ref.getDownloadURL();
      return Right(downloadableUrl);
    } catch (e) {
      print(e.toString());
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  Future<Either<Failure, String>> uploadPhotoOnFirebaseStorage(
      Uint8List file) async {
    final mimType = AppUtils.getMimeType(file);
    try {
      final uploadTask = await firebaseStorage
          .ref('reelsThumbNails')
          .child(uuid.v4())
          .putData(file, SettableMetadata(contentType: mimType));
      final downloadableUrl = await (uploadTask).ref.getDownloadURL();
      return Right(downloadableUrl);
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> fetchReels() async {
    try {
      final data = await firestore.collection('reels').get();
      final reels = data.docs.map((e) => Post.fromMap(e.data())).toList();
      return Right(reels);
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> fetchReelsOfUser(String uid) async {
    try {
      final data = await firestore
          .collection('reels')
          .where('postedBy', isEqualTo: uid)
          .get();
      final userReels = data.docs.map((e) => Post.fromMap(e.data())).toList();
      return Right(userReels);
    } catch (e) {
      return Left(Failure(message: e.toString(), errorCode: ''));
    }
  }
}
