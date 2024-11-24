import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/new_stories_screen.dart'; // Import the NewStoriesScreen

class AddStoryScreen extends StatefulWidget {
  @override
  _AddStoryScreenState createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String story = '';
  String imageUrl = '';

  Future<void> uploadData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new document ID based on the title
      String documentId = title.toLowerCase().replaceAll(' ', '_');

      try {
        await FirebaseFirestore.instance
            .collection('newstories')
            .doc(documentId)
            .set({
          'title': title,
          'story': story,
          'image': imageUrl,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your story has been added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to NewStoriesScreen after successful upload
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NewStoriesScreen()),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add story: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Story'),
        centerTitle: true,
        backgroundColor: Color(0xFF6E62C9),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter the name of Prophet/Saint',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSaved: (value) {
                  title = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Type the story',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSaved: (value) {
                  story = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a story';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Add image URL',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSaved: (value) {
                  imageUrl = value!;
                },
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: uploadData,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    backgroundColor: Color(0xFF6E62C9),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
