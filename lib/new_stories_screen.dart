import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/add_stories.dart';

class NewStoriesScreen extends StatefulWidget {
  const NewStoriesScreen({super.key});

  @override
  _NewStoriesScreenState createState() => _NewStoriesScreenState();
}

class _NewStoriesScreenState extends State<NewStoriesScreen> {
  final CollectionReference _storiesCollection =
      FirebaseFirestore.instance.collection('newstories');

  Future<void> _editStory(String documentId, String currentTitle,
      String currentStory, String currentImageUrl) async {
    final titleController = TextEditingController(text: currentTitle);
    final storyController = TextEditingController(text: currentStory);
    final imageUrlController = TextEditingController(text: currentImageUrl);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Story'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: storyController,
                  decoration: const InputDecoration(labelText: 'Story'),
                  maxLines: 5,
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update Firestore document
                await _storiesCollection.doc(documentId).update({
                  'title': titleController.text,
                  'story': storyController.text,
                  'image': imageUrlController.text,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Story updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
                      'NEW STORIES',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 4, 33, 37),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _storiesCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error fetching stories.'));
                      }

                      final documents = snapshot.data?.docs ?? [];

                      if (documents.isEmpty) {
                        return const Center(
                            child: Text('No stories available.'));
                      }

                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final documentId = documents[index].id;
                          final data =
                              documents[index].data() as Map<String, dynamic>;
                          final title = data['title'] ?? '';
                          final story = data['story'] ?? '';
                          final imageUrl = data['image'] ?? '';

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Center(
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () {
                                          _editStory(documentId, title, story,
                                              imageUrl);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () async {
                                          final confirmDelete =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Delete Story'),
                                                content: const Text(
                                                    'Are you sure you want to delete this story?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          if (confirmDelete == true) {
                                            await _storiesCollection
                                                .doc(documentId)
                                                .delete();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Story deleted successfully!'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StoryDetailScreen(
                                            documentId: documentId),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddStoryScreen()),
                    );
                  },
                  child: const Text(
                    'Add New Story',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    backgroundColor: const Color.fromARGB(255, 10, 101, 238),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoryDetailScreen extends StatelessWidget {
  final String documentId;

  const StoryDetailScreen({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    final CollectionReference _storiesCollection =
        FirebaseFirestore.instance.collection('newstories');

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _storiesCollection.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              !snapshot.data!.exists) {
            return const Center(child: Text('Error loading story.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final String title = data['title'] ?? 'Unknown';
          final String imageUrl = data['image'] ?? '';
          final String storyText = data['story'] ?? 'No story available.';

          return Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6E62C9), Color(0xFFB39DDB)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        if (imageUrl.isNotEmpty)
                          Image.network(
                            imageUrl,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        const SizedBox(height: 16.0),
                        Text(
                          storyText,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
