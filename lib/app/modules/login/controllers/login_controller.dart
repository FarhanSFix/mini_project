import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user!.emailVerified) {
        Get.snackbar('Success', 'User logged in successfully');
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar('Error', 'Please verify your email');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('wrong email');
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('wrong password');
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else if (e.code == 'too-many-requests') {
        print('too-many-requests');
        Get.snackbar('Error', 'Too many requests. Try again later.');
      }
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
