import 'dart:async';

import 'package:get/get.dart';

import '../config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_key');
    await Future.delayed(const Duration(seconds: 3));
    if (token != null) {
      Get.offAllNamed('mainPage');
    } else {
      Get.offAllNamed('mainPage');
      // Get.offAllNamed('login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
          AssetsImage.logoBig,
            height: 150,
            width: 250,
          ),
        ),
      ),
    );
  }
}
