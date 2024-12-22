import 'package:flutter/material.dart';
import 'package:flutter_application_1/select_stories.dart';

class AgeSelectionScreen extends StatelessWidget {
  const AgeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Ensures content doesn't overlap with system UI
            child: Column(
              children: [
                // Title at the top, similar to AppBar
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'SELECT THE AGE',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Age selection buttons
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
                                    StorySelectionScreen(ageGroup: '3-6')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 47, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '3-6 Years Old',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF6E62C9)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StorySelectionScreen(ageGroup: '7-10')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '7-10 Years Old',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF6E62C9)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StorySelectionScreen(ageGroup: '11-12')),
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
                          '10-12 Years Old',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF6E62C9)),
                        ),
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
    );
  }
}
