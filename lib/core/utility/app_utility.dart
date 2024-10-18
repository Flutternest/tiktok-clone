import 'dart:io';
import 'dart:math';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/session.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktokclone/core/constants/constants.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AppUtils {
  static bool emailValidation(String value) {
    final validEmail =
        RegExp(r"^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$");
    return validEmail.hasMatch(value);
  }

  static String? emailValidate(String? value) {
    if (value!.isNotEmpty) {
      if (emailValidation(value.trim())) {
        return null;
      } else {
        return AppString.invalidEmail;
      }
    } else {
      return AppString.enterYourEmail;
    }
  }

  static Future<File?> compress(String path, String postId) async {
    Directory tempDir = await getTemporaryDirectory();
    final outputPath = "${tempDir.path}/$postId.mp4";
    final String command =
        '-y -i $path  -c:v libx264 -b:a 44100 -crf 30 -ar 22050 -tune fastdecode -preset ultrafast $outputPath';
    await FFmpegKit.execute(command);
    return File(outputPath);
  }

  static String? passwordValidate(String? value) {
    if (value!.isNotEmpty) {
      if (value.length < 6) {
        return AppString.passwordValidation;
      } else {
        return null;
      }
    } else {
      return AppString.enterYourPassword;
    }
  }

  static String generateUsername(String familyName) {
    Random random = Random();
    int threeDigitNumber = random.nextInt(900) + 100;
    return '$familyName$threeDigitNumber';
  }

  static String extractFirstName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    if (nameParts.isNotEmpty) {
      return nameParts[0];
    } else {
      return '';
    }
  }

  static String extractLastName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    if (nameParts.length == 2) {
      return nameParts[1];
    } else if (nameParts.isNotEmpty) {
      return nameParts[0];
    } else {
      return '';
    }
  }

  static String? fieldEmpty(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return AppString.fieldCanNotBeEmpty;
    }
  }

  static Future<XFile?> videoPickerFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickVideo(
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 1),
        source: ImageSource.camera);
    return image;
  }

  static Future<XFile?> videoPickerFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickVideo(
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 1),
        source: ImageSource.gallery);
    return image;
  }

  static Future<XFile?> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    return image;
  }

  static Future<Uint8List?> getImageFromVideo(XFile? videofile) async {
    final image = await VideoThumbnail.thumbnailData(
        video: videofile!.path,
        imageFormat: ImageFormat.JPEG,
        quality: 80,
        maxHeight: 500,
        maxWidth: 400);
    return image;
  }

  static String getMimeType(Uint8List bytes) {
    // Convert Uint8List to List<int>
    List<int> byteList = bytes.toList();

    // Get the MIME type
    String? mimeType = lookupMimeType('', headerBytes: byteList);

    return mimeType ?? ''; // Return a default if MIME type is not found
  }
}
