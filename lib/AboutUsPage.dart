import 'package:flutter/material.dart';
import 'HomeScreen.dart'; // Import HomeScreen

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Start fade-in animation for the content
    _controller.forward();
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
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white), // Change text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 233, 71, 130),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Makes the content scrollable
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _controller.value,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center the content
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 175,
                        height: 175,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome to Muskurahatt!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'At Muskurahatt, we believe in the joy of giving! Our gift shop is a one-stop destination for thoughtful and unique gifts that bring smiles to your loved ones. Whether it\'s a birthday, anniversary, or any special occasion, we offer a curated collection of items that express love, care, and happiness.',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center, // Center the text
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Why Choose Us?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '• Exclusive collection of unique gifts\n'
                      '• Handpicked products with love and care\n'
                      '• Fast and reliable delivery services\n'
                      '• Customizable gift options\n'
                      '• Secure online shopping experience',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center, // Center the text
                    ),
                    const SizedBox(height: 30), // Add some spacing
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 248, 247, 247),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      ),
                      child: const Text(
                        'Start Shopping Now!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
