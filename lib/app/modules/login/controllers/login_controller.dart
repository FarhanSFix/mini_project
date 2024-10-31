import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginWithUsername() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    if (username.isEmpty && password.isEmpty) {
      Get.snackbar("error", "pastikan semua kolom terisi");
    }
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (snapshot.docs.isEmpty) {
        Get.snackbar("Error", "Username not found");
        return;
      }

      String email = snapshot.docs[0]['email'];

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
