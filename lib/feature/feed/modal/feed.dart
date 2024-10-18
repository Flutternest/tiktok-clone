// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Feed {
  final String videoUrl;
  final String postId;
  final String postedBy;
  final DateTime createdTime;
  final int numberOfComments;
  final int numberOfLikes;
  final int numberOfViews;
  final String thumbNailUrl;
  final String description;
  Feed({
    required this.videoUrl,
    required this.postId,
    required this.postedBy,
    required this.createdTime,
    required this.numberOfComments,
    required this.numberOfLikes,
    required this.numberOfViews,
    required this.thumbNailUrl,
    required this.description,
  });

  Feed copyWith({
    String? videoUrl,
    String? postId,
    String? postedBy,
    DateTime? createdTime,
    int? numberOfComments,
    int? numberOfLikes,
    int? numberOfViews,
    String? thumbNailUrl,
    String? description,
  }) {
    return Feed(
      videoUrl: videoUrl ?? this.videoUrl,
      postId: postId ?? this.postId,
      postedBy: postedBy ?? this.postedBy,
      createdTime: createdTime ?? this.createdTime,
      numberOfComments: numberOfComments ?? this.numberOfComments,
      numberOfLikes: numberOfLikes ?? this.numberOfLikes,
      numberOfViews: numberOfViews ?? this.numberOfViews,
      thumbNailUrl: thumbNailUrl ?? this.thumbNailUrl,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'videoUrl': videoUrl,
      'postId': postId,
      'postedBy': postedBy,
      'createdTime': createdTime.toIso8601String(),
      'numberOfComments': numberOfComments,
      'numberOfLikes': numberOfLikes,
      'numberOfViews': numberOfViews,
      'thumbNailUrl': thumbNailUrl,
      'description': description,
    };
  }

  factory Feed.fromMap(Map<String, dynamic> map) {
    return Feed(
      videoUrl: map['videoUrl'] as String,
      postId: map['postId'] as String,
      postedBy: map['postedBy'] as String,
      createdTime: DateTime.parse(map['createdTime'] as String),
      numberOfComments: map['numberOfComments'] as int,
      numberOfLikes: map['numberOfLikes'] as int,
      numberOfViews: map['numberOfViews'] as int,
      thumbNailUrl: map['thumbNailUrl'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Feed.fromJson(String source) =>
      Feed.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(videoUrl: $videoUrl, postId: $postId, postedBy: $postedBy, createdTime: $createdTime, numberOfComments: $numberOfComments, numberOfLikes: $numberOfLikes, numberOfViews: $numberOfViews, thumbNailUrl: $thumbNailUrl, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Feed &&
        other.videoUrl == videoUrl &&
        other.postId == postId &&
        other.postedBy == postedBy &&
        other.createdTime == createdTime &&
        other.numberOfComments == numberOfComments &&
        other.numberOfLikes == numberOfLikes &&
        other.numberOfViews == numberOfViews &&
        other.thumbNailUrl == thumbNailUrl &&
        other.description == description;
  }

  @override
  int get hashCode {
    return videoUrl.hashCode ^
        postId.hashCode ^
        postedBy.hashCode ^
        createdTime.hashCode ^
        numberOfComments.hashCode ^
        numberOfLikes.hashCode ^
        numberOfViews.hashCode ^
        thumbNailUrl.hashCode ^
        description.hashCode;
  }
}
