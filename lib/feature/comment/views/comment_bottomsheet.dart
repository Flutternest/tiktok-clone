import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/feature/comment/provider/fetch_comments_provider.dart';
import 'package:tiktokclone/feature/comment/repositary/comment_repositary.dart';
import 'package:tiktokclone/feature/comment/shimmer/comment_shimmer.dart';
import 'package:tiktokclone/feature/home/components/comment_item.dart';
import 'package:tiktokclone/feature/comment/modal/reel_comment_model.dart';
import 'package:uuid/uuid.dart';

class CommentBottomSheet extends ConsumerStatefulWidget {
  final String postId;
  const CommentBottomSheet({Key? key, required this.postId}) : super(key: key);

  @override
  ConsumerState<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends ConsumerState<CommentBottomSheet> {
  final commentController = TextEditingController(text: '');
  final Uuid uuid = Uuid();
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(fetchCommentsProvider(widget.postId));
    return comments.when(
      data: (res) {
        return res.fold((left) {
          return Text('Something went wrong');
        }, (comments) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    'Comments',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                if (comments.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      itemCount: comments.length,
                      itemBuilder: (ctx, i) =>
                          CommentItem(commentItem: comments[i]),
                    ),
                  ),
                if (comments.isEmpty)
                  const Expanded(
                      child: Center(
                    child: Text('No Comments yet.'),
                  )),
                const Divider(),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.all(10),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      suffixIcon: InkWell(
                          onTap: () async {
                            String comment = commentController.text;
                            final ReelCommentModel reelCommentModel =
                                ReelCommentModel(
                                    commentId: uuid.v4().toString(),
                                    commentText: comment,
                                    commentTime: DateTime.now(),
                                    commentBy:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    postId: widget.postId);
                            await ref
                                .read(commentRespositaryProvider)
                                .doComment(commentModel: reelCommentModel);
                            ref.invalidate(fetchCommentsProvider);
                            commentController.clear();
                          },
                          child: const Icon(Icons.send)),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
      error: (Object error, StackTrace stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return CommentShimmer();
      },
    );
  }
}
