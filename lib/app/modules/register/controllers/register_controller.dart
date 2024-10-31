import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void register(String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      Get.snackbar("Error", "Password tidak cocok");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Get.snackbar('Success', 'User created successfully');
        userCredential.user!.sendEmailVerification();
        Get.defaultDialog(
            title: 'Verify your email',
            middleText:
                'Please verify your email to continue. We have sent you an email verification link.',
            textConfirm: 'OK',
            textCancel: 'Resend',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            onCancel: () {
              userCredential.user!.sendEmailVerification();
              Get.snackbar('Success', 'Email verification link sent');
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('Error', 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Error', 'The account already exists for that email.');
        }
        print(e.code);
      } catch (e) {
        print(e);
      }
    }
  }

  void saveData(String email, String nama, String alamat, String phone) async {
    try {
      await firestore.collection("users").add({
        'email': email,
        'name': nama,
        'address': alamat,
        'phoneNumber': phone
      });
      Get.back();
      Get.snackbar('Success', 'Data added successfully');
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
