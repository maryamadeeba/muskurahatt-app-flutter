import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:splash_screen/models/post_api.dart';



class AccountPage extends StatelessWidget {

  const AccountPage({Key? key}) : super(key: key);



  // Function to fetch user data from API

  Future<PostApi> _fetchUserData(int userId) async {

    final response = await http.get(Uri.parse('https://fakestoreapi.com/users/$userId'));



    if (response.statusCode == 200) {

      // Parse JSON response

      final jsonData = json.decode(response.body);

      return PostApi.fromJson(jsonData); // Fetch user data based on userId

    } else {

      throw Exception('Failed to load user data');

    }

  }



  @override

  Widget build(BuildContext context) {

    final userId = ModalRoute.of(context)!.settings.arguments as int? ?? 1; // Use passed userId or default to 1

    return Scaffold(

      appBar: AppBar(

        title: const Text('Account'),

      ),

      body: FutureBuilder<PostApi>(

        future: _fetchUserData(userId),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {

            return const Center(child: CircularProgressIndicator()); // Show loading spinner while fetching data

          } else if (snapshot.hasError) {

            return Center(child: Text('Error: ${snapshot.error}'));

          } else if (!snapshot.hasData || snapshot.data == null) {

            return const Center(child: Text('Failed to load user data'));

          } else {

            final userData = snapshot.data!;



            return ListView(

              padding: const EdgeInsets.all(16.0),

              children: [

                // Profile Picture and Basic Info

                const Center(

                  child: CircleAvatar(

                    radius: 50,

                    backgroundImage: AssetImage(

                      'assets/images/avatar.jpg',

                    ),

                  ),

                ),

                const SizedBox(height: 20),

                Text(

                  '${userData.name?.firstname ?? 'First Name'} ${userData.name?.lastname ?? 'Last Name'}',

                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

                  textAlign: TextAlign.center,

                ),

                Text(

                  userData.email ?? 'No Email',

                  style: const TextStyle(fontSize: 16, color: Colors.grey),

                  textAlign: TextAlign.center,

                ),

                const SizedBox(height: 20),



                // List of Options

                ListTile(

                  title: const Text('Edit Profile'),

                  leading: const Icon(Icons.edit),

                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));

                  },

                ),

                ListTile(

                  title: const Text('Order History'),

                  leading: const Icon(Icons.history),

                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryPage()));

                  },

                ),

                ListTile(

                  title: const Text('Change Password'),

                  leading: const Icon(Icons.lock),

                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage()));

                  },

                ),

                ListTile(

                  title: const Text('Settings'),

                  leading: const Icon(Icons.settings),

                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));

                  },

                ),

                ListTile(

                  title: const Text('Help & Support'),

                  leading: const Icon(Icons.help),

                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpSupportPage()));

                  },

                ),

                ListTile(

                  title: const Text('Logout'),

                  leading: const Icon(Icons.logout, color: Colors.red),

                  textColor: Colors.red,

                  onTap: () {

                    _logout(context);

                  },

                ),

              ],

            );

          }

        },

      ),

    );

  }



  void _logout(BuildContext context) {

    showDialog(

      context: context,

      builder: (context) => AlertDialog(

        title: const Text('Logout'),

        content: const Text('Are you sure you want to logout?'),

        actions: [

          TextButton(

            onPressed: () => Navigator.pop(context),

            child: const Text('Cancel'),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(context);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));

            },

            child: const Text('Logout'),

          ),

        ],

      ),

    );

  }

}



// Dummy Screens for other pages

class EditProfilePage extends StatelessWidget {

  const EditProfilePage({Key? key}) : super(key: key);



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text('Edit Profile')),

      body: const Center(child: Text('Edit Profile Screen')),

    );

  }

}



// Other pages can remain the same as in the original code...

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});



  @override

  _LoginScreenState createState() => _LoginScreenState();

}



class _LoginScreenState extends State<LoginScreen> {

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();



  // Validate and proceed to the next screen after successful login

  void _login() async {

    final response = await http.get(Uri.parse('https://fakestoreapi.com/users'));

    final List<dynamic> users = json.decode(response.body);



    for (var user in users) {

      if (user['username'] == _usernameController.text && user['password'] == _passwordController.text) {

        // User is found and credentials match

        Navigator.pushReplacementNamed(context, '/account', arguments: user['id']);

        return;

      }

    }



    // If no matching user found

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid username or password')));

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFFCE4EC), // Light pink background color

      appBar: AppBar(

        title: const Text("Login"),

        backgroundColor: const Color.fromARGB(255, 217, 93, 118),

      ),

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(24.0),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              // Logo or Image

              ClipOval(

                child: Image.asset(

                  'assets/images/logo.png', // Replace with your logo

                  width: 250,

                  height: 250,

                  fit: BoxFit.cover,

                ),

              ),

              const SizedBox(height: 40),



              // Username TextField

              TextField(

                controller: _usernameController,

                decoration: InputDecoration(

                  labelText: 'Username',

                  labelStyle: const TextStyle(color: Colors.pink),

                  prefixIcon: const Icon(Icons.person, color: Colors.pink),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(15),

                    borderSide: BorderSide.none,

                  ),

                  focusedBorder: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(15),

                    borderSide: const BorderSide(color: Colors.pink, width: 2),

                  ),

                ),

              ),

              const SizedBox(height: 20),



              // Password TextField

              TextField(

                controller: _passwordController,

                obscureText: true,

                decoration: InputDecoration(

                  labelText: 'Password',

                  labelStyle: const TextStyle(color: Colors.pink),

                  prefixIcon: const Icon(Icons.lock, color: Colors.pink),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(15),

                    borderSide: BorderSide.none,

                  ),

                  focusedBorder: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(15),

                    borderSide: const BorderSide(color: Colors.pink, width: 2),

                  ),

                ),

              ),

              const SizedBox(height: 30),



              // Login Button

              ElevatedButton(

                onPressed: _login,

                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color.fromARGB(255, 247, 246, 246), // Pink color for the button

                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(30),

                  ),

                ),

                child: const Text(

                  'Login',

                  style: TextStyle(fontSize: 18),

                ),

              ),

              const SizedBox(height: 20),



              // Sign Up Text

              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Text(

                    'Don\'t have an account? ',

                    style: TextStyle(color: Colors.black),

                  ),

                  GestureDetector(

                    onTap: () {

                      // Navigate to the Sign Up screen

                    },

                    child: const Text(

                      'Sign Up',

                      style: TextStyle(

                        color: Colors.pink,

                        fontWeight: FontWeight.bold,

                      ),

                    ),

                  ),

                ],

              ),

            ],

          ),

        ),

      ),

    );

  }

}
class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: const Center(child: Text('Order History Screen')),
    );
  }
}
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: const Center(child: Text('Change Password Screen')),
    );
  }
}
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}
class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: const Center(child: Text('Help & Support Screen')),
    );
  }
}
