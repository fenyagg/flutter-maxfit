import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String id;
  String email;

  AppUser.fromFirebase(User user) {
    id = user.uid;
    email = user.email;
  }
}