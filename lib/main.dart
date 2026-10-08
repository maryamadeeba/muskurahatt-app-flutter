import 'package:flutter/material.dart';
import 'package:splash_screen/AboutUsPage.dart';
import 'ProductsPage.dart'; // Products Page
import 'HomeScreen.dart';
// Home Page

void main() {
  runApp(const MuskurahattApp());
}

class MuskurahattApp extends StatelessWidget {
  const MuskurahattApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

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

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
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
                    width: 220,
                    height: 220,
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

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink),
            child: Center(
              child: Text(
                'Muskurahatt Menu',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Products'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductsPage()),
              );
            },
          ),
                    ListTile(
            leading: const Icon(Icons.category),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsScreen()),
              );
            },
          ),
          ListTile(
  leading: const Icon(Icons.info),
  title: const Text('About Us'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsScreen()),
    );
  },
),

        ],
      ),
    );
  }
}
