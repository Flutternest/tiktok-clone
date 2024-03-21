// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReelCommentModel {
  final String commentId;
  final String commentText;
  final DateTime commentTime;
  final String commentBy;
  final String postId;
  ReelCommentModel({
    required this.commentId,
    required this.commentText,
    required this.commentTime,
    required this.commentBy,
    required this.postId,
  });

  ReelCommentModel copyWith({
    String? commentId,
    String? commentText,
    DateTime? commentTime,
    String? commentBy,
    String? postId,
  }) {
    return ReelCommentModel(
      commentId: commentId ?? this.commentId,
      commentText: commentText ?? this.commentText,
      commentTime: commentTime ?? this.commentTime,
      commentBy: commentBy ?? this.commentBy,
      postId: postId ?? this.postId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'commentText': commentText,
      'commentTime': commentTime.toUtc().toIso8601String(),
      'commentBy': commentBy,
      'postId': postId,
    };
  }

  factory ReelCommentModel.fromMap(Map<String, dynamic> map) {
    return ReelCommentModel(
      commentId: map['commentId'] as String,
      commentText: map['commentText'] as String,
      commentTime: DateTime.parse(map['commentTime']).toLocal(),
      commentBy: map['commentBy'] as String,
      postId: map['postId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReelCommentModel.fromJson(String source) =>
      ReelCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReelCommentModel(commentId: $commentId, commentText: $commentText, commentTime: $commentTime, commentBy: $commentBy, postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReelCommentModel &&
        other.commentId == commentId &&
        other.commentText == commentText &&
        other.commentTime == commentTime &&
        other.commentBy == commentBy &&
        other.postId == postId;
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
        commentText.hashCode ^
        commentTime.hashCode ^
        commentBy.hashCode ^
        postId.hashCode;
  }
}
