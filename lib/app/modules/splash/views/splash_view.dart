import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeef2ff),
        body: SafeArea(
          child: Stack(children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images/Vector2.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/Vector1.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/images/Vector3.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/images/Vector4.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.sizeOf(context).height / 2,
                width: MediaQuery.sizeOf(context).width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "HELLO FELLAS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "temukan segala jenis bunga dari berbagai belahan dunia",
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
