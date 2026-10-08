import 'package:flutter/material.dart';
import 'HomeScreen.dart'; // Import HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Start fade-in animation
    _controller.forward();

    // Navigate to the HomeScreen after the splash screen
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 250, 251),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 130.0),
                ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/teddy.png',
                width: 275,
                height: 275,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
