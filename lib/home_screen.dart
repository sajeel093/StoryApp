import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemNavigator
import 'package:flutter_application_1/login_screen.dart';

import 'package:flutter_application_1/new_stories_screen.dart';

import 'package:flutter_application_1/select_age.dart';

class MainScreen extends StatefulWidget {
  final String username;

  MainScreen({required this.username});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to close the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); // Close the app
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false; // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Navigate back to the login screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginPage(), // Replace with your login screen
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            // Background image covering the entire screen
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/BG.jpg'), // Path to your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content of the screen
            SafeArea(
              child: Column(
                children: [
                  // Display the username at the top
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Hi ${widget.username}',
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Title at the top, similar to AppBar
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        ' STORIES',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Story selection buttons
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AgeSelectionScreen(), // Default age group
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 58, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Stories',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF6E62C9)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Stack(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewStoriesScreen(
                                        username: widget.username),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Newly Added Stories',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFF6E62C9)),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: FadeTransition(
                                opacity: _animation,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  color: Colors
                                      .red, // Background color for the banner
                                  child: const Text(
                                    'New',
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(), // To push buttons toward the center
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
