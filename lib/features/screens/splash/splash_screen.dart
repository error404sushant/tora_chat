import 'package:flutter/material.dart';
import 'package:tora_chat/features/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //region Init
  @override
  void initState() {
    super.initState();
    // You can navigate to another screen after a delay (e.g., 3 seconds)
    Future.delayed( const Duration(seconds: 2), () {
      // Navigate to the next screen (e.g., Home screen)
      Navigator.pushReplacement( context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }
  //endregion

  //region Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0), // Adjust this value for more or less rounded corners
          child: Image.asset(
            'assets/app_icon.png',
            height: 100,
            width: 100,
            fit: BoxFit.cover, // Ensures the image covers the entire area without distortion
          ),
        ),
      ),
    );
  }
  //endregion
}