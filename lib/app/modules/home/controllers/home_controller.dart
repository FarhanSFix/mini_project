import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/modules/login/views/login_view.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var getEmail = Get.arguments;

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDataStream() {
    final User? user = auth.currentUser;
    if (user != null) {
      return firestore.collection('users').doc(user.uid).snapshots();
    } else {
      throw Exception("User is not logged in");
    }
  }
}
