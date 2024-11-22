import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/add_screen.dart';
import 'package:flutter_application_1/storyScreen.dart';

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
  ];

  Future<Map<String, String>> fetchStory(String prophet) async {
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
          'image': '',
        };
      }

      // Convert prophet name to lowercase and replace spaces with underscores
      String documentId = prophet.toLowerCase().replaceAll(' ', '_');

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .get();
      return {
        'story': doc['story'] ?? 'No story available',
        'image': doc['image'] ?? '',
      };
    } catch (e) {
      print('Error fetching story: $e');
      return {
        'story': 'Error fetching story',
        'image': '',
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
                          print('Tapped on: ${prophets[index]}');
                          Map<String, String> data =
                              await fetchStory(prophets[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoryScreen(
                                      story: data['story']!,
                                      imageUrl: data['image']!,
                                    )),
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
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF6E62C9),
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddStoryScreen()),
            );
          },
        ),
      ),
    );
  }
}
