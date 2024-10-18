// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Failure {
  final String message;
  final String errorCode;
  Failure({
    required this.message,
    required this.errorCode,
  });

  Failure copyWith({
    String? message,
    String? errorCode,
  }) {
    return Failure(
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'errorCode': errorCode,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      message: map['message'] as String,
      errorCode: map['errorCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) => Failure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Failure(message: $message, errorCode: $errorCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Failure &&
      other.message == message &&
      other.errorCode == errorCode;
  }

  @override
  int get hashCode => message.hashCode ^ errorCode.hashCode;
}
