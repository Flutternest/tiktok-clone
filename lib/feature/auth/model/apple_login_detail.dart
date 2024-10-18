class AppleLoginDetails {
  final String email;
  final String firstName;
  final String token;
  final String lastName;

//<editor-fold desc="Data Methods">
  const AppleLoginDetails({
    required this.email,
    required this.firstName,
    required this.token,
    required this.lastName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppleLoginDetails &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          firstName == other.firstName &&
          token == other.token &&
          lastName == other.lastName);

  @override
  int get hashCode =>
      email.hashCode ^ firstName.hashCode ^ token.hashCode ^ lastName.hashCode;

  @override
  String toString() {
    return 'AppleLoginDetails{' +
        ' email: $email,' +
        ' firstName: $firstName,' +
        ' token: $token,' +
        ' lastName: $lastName,' +
        '}';
  }

  AppleLoginDetails copyWith({
    String? email,
    String? firstName,
    String? token,
    String? lastName,
  }) {
    return AppleLoginDetails(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      token: token ?? this.token,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'firstName': this.firstName,
      'token': this.token,
      'lastName': this.lastName,
    };
  }

  factory AppleLoginDetails.fromMap(Map<String, dynamic> map) {
    return AppleLoginDetails(
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      token: map['token'] as String,
      lastName: map['lastName'] as String,
    );
  }

//</editor-fold>
}
