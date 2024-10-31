import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/Vector6.png",
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/Vector7.png",
                  fit: BoxFit.cover,
                ),
              ),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.getUserDataStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    var userData = snapshot.data!.data();
                    if (userData != null) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Hallo, ${userData['name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            subtitle: Text("How's your day going?"),
                          ),
                          Container(
                              width: MediaQuery.sizeOf(context).width / 1.1,
                              child: Column(
                                children: [
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "My Phone Number : ${userData['phoneNumber']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "My Address : ${userData['address']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                        ],
                      );
                    } else {
                      return Center(child: const Text("User data not found."));
                    }
                  } else {
                    return Center(child: const Text("Data Not Found!"));
                  }
                },
              ),
              Center(
                child: Container(
                  height: 40,
                  width: MediaQuery.sizeOf(context).width / 1.1,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.purple[300],
                        foregroundColor: Colors.white),
                    child: Text("Upload Foto"),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
