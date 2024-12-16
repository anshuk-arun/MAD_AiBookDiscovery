import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String password;


  User ({
    required this.email,
    required this.password,
  });

  User.fromJson(Map<String, Object?> json)
    : this(
        email: json['email']! as String,
        password: json['password']! as String
      );

  User copyWith({
    String? email,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password
    );
  }

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}