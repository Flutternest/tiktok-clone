// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserData {
  final String firstName;
  final String lastName;
  final String userName;
  final String uid;
  final DateTime createdTime;
  final String email;
  final String bio;
  final String profileUrl;
  UserData({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.uid,
    required this.createdTime,
    required this.email,
    required this.bio,
    required this.profileUrl,
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? userName,
    String? uid,
    DateTime? createdTime,
    String? email,
    String? bio,
    String? profileUrl,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      uid: uid ?? this.uid,
      createdTime: createdTime ?? this.createdTime,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'uid': uid,
      'createdTime': createdTime.toUtc(),
      'email': email,
      'bio': bio,
      'profileUrl': profileUrl,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      firstName: map['firstName'],
      lastName: map['lastName'],
      userName: map['userName'],
      uid: map['uid'],
      createdTime: map['createdTime'],
      email: map['email'],
      bio: map['bio'],
      profileUrl: map['profileUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, userName: $userName, uid: $uid, createdTime: $createdTime, email: $email, bio: $bio, profileUrl: $profileUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userName == userName &&
        other.uid == uid &&
        other.createdTime == createdTime &&
        other.email == email &&
        other.bio == bio &&
        other.profileUrl == profileUrl;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        userName.hashCode ^
        uid.hashCode ^
        createdTime.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        profileUrl.hashCode;
  }
}
