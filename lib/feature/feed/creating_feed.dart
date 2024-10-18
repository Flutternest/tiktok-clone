import 'dart:io';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/app_utility.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';
import 'package:tiktokclone/feature/feed/provider/feed_provider.dart';
import 'package:tiktokclone/feature/feed/repositary/feed_repositary.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class CreatingPostPage extends ConsumerStatefulWidget {
  const CreatingPostPage({super.key, required this.xfile});
  final XFile xfile;

  @override
  ConsumerState<CreatingPostPage> createState() => _CreatingPostPageState();
}

class _CreatingPostPageState extends ConsumerState<CreatingPostPage> {
  final TextEditingController descriptionEditingController = TextEditingController();
  final Uuid uuid = Uuid();
  Future<void> postTikTokVideo() async {
    final postid = uuid.v4().toString();
    final file = await AppUtils.compress(widget.xfile.path, postid);
    final response = await ref.read(tikTokRepositaryProvider).addTikTokVideo(file!.path, descriptionEditingController.text.trim(), postid);
    response.fold((left) {Fluttertoast.showToast(msg: left.message);
    }, (right) {
      Fluttertoast.showToast(msg: 'Video uploaded successfully');
      context.router.pop();
    });
  }

  @override
  void dispose() {
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Text(
          'Post',
          style: appTheme.displaySmall?.copyWith(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return CommonPadding(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  verticalSpaceSmall,
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 110,
                        child: TextField(
                          controller: descriptionEditingController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Describe your Video',
                            errorBorder: OutlineInputBorder(
                              //<-- SEE HERE
                              borderSide:
                                  BorderSide(width: 3, color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder<Uint8List?>(
                          future: AppUtils.getImageFromVideo(widget.xfile),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return Container(
                              height: 100,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(snapshot.data!),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink),
                      onPressed: () async {
                        final progress = ProgressHUD.of(context);
                        progress?.showWithText('uploading');
                        await postTikTokVideo();
                        ref.invalidate(tikTokVideosProvider);
                        progress?.dismiss();
                      },
                      child: Text(
                        'Post',
                        style: appTheme.displaySmall
                            ?.copyWith(color: Colors.white),
                      )),
                  verticalSpaceMedium,
                ]),
          );
        }),
      ),
    ));
  }
}
