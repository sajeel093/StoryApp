import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_application_1/display_stories_screen.dart';

class ProphetsScreen extends StatefulWidget {
  final String ageGroup;

  const ProphetsScreen({super.key, required this.ageGroup});

  @override
  _ProphetsScreenState createState() => _ProphetsScreenState();
}

class _ProphetsScreenState extends State<ProphetsScreen> {
  final List<String> prophets = [
    'Hazrat Adam Alaihis Salam',
    'Hazrat Nuh Alaihis Salam',
    'Hazrat Idris Alaihis Salam',
    'Hazrat Lut Alaihis Salam',
    'Hazrat Ibrahim Alaihis Salam',
    'Hazrat Musa Alaihis Salam',
  ];

  Future<Map<String, dynamic>> fetchStory(String prophet) async {
    try {
      String collectionName;
      if (widget.ageGroup == '3-6') {
        collectionName = 'prophets3to6';
      } else if (widget.ageGroup == '7-10') {
        collectionName = 'prophets7to10';
      } else if (widget.ageGroup == '11-12') {
        collectionName = 'prophets11to12';
      } else {
        return {
          'story': 'Error fetching story',
          'images': [],
        };
      }

      String documentId = prophet.toLowerCase().replaceAll(' ', '_');
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .get();
      return {
        'story': doc['story'] ?? 'No story available',
        'images': List<String>.from(doc['image'] ?? []), // Fetching as a list
      };
    } catch (e) {
      print('Error fetching story: $e');
      return {
        'story': 'Error fetching story',
        'images': [],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BG.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'STORIES OF THE PROPHETS',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 4, 33, 37),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: prophets.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> data =
                              await fetchStory(prophets[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoryScreen(
                                story: data['story']!,
                                imageUrls: List<String>.from(data['images']),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                prophets[index],
                                style: const TextStyle(
                                    fontSize: 18, color: Color(0xFF6E62C9)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
