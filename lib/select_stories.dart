import 'package:flutter/material.dart';
import 'package:flutter_application_1/muslim_saints_screen.dart';
import 'package:flutter_application_1/prophet_screen.dart';

class StorySelectionScreen extends StatelessWidget {
  final String ageGroup;

  const StorySelectionScreen({super.key, required this.ageGroup});

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
            child: Column(
              children: [
                // Title at the top, similar to AppBar
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'SELECT STORIES',
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
                                      ProphetsScreen(ageGroup: ageGroup)));
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
                          'Prophets',
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
                                      MuslimSaintsScreen(ageGroup: ageGroup)));
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
                          'Muslim Saints',
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
