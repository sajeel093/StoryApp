import 'package:flutter/material.dart';
import 'package:flutter_application_1/add_stories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/storyScreen.dart';

class MuslimSaintsScreen extends StatefulWidget {
  final String ageGroup;

  const MuslimSaintsScreen({super.key, required this.ageGroup});

  @override
  _MuslimSaintsScreenState createState() => _MuslimSaintsScreenState();
}

class _MuslimSaintsScreenState extends State<MuslimSaintsScreen> {
  final List<String> muslimSaints = [
    'Hazrat Data Ganj Bakhsh',
    'Hazrat Abdullah Shah Ghazi',
    'Hazrat Lal Shahbaz Qalandar',
    'Hazrat Bahauddin Zakaria',
    'Hazrat Abdul Qadir Gilani',
  ];

  Future<Map<String, String>> fetchStory(String saint) async {
    try {
      String collectionName;
      if (widget.ageGroup == '3-6') {
        collectionName = 'saints3to6';
      } else if (widget.ageGroup == '7-10') {
        collectionName = 'saints7to10';
      } else if (widget.ageGroup == '11-12') {
        collectionName = 'saints11to12';
      } else {
        return {
          'story': 'Error fetching story',
          'image': '',
        };
      }

      String documentId = saint.toLowerCase().replaceAll(' ', '_');
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
                      'STORIES OF THE MUSLIM SAINTS',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: muslimSaints.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          Map<String, String> data =
                              await fetchStory(muslimSaints[index]);
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
                                muslimSaints[index],
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
