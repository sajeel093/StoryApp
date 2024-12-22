import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/new_stories_screen.dart';

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
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6E62C9), Color(0xFFB39DDB)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTextField(
                        hintText: 'Enter the name of Prophet/Saint',
                        onSaved: (value) => title = value!,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a title'
                            : null,
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        hintText: 'Type the story',
                        onSaved: (value) => story = value!,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a story'
                            : null,
                        maxLines: 10,
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        hintText: 'Add image URL',
                        onSaved: (value) => imageUrl = value!,
                      ),
                      SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: uploadData,
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            backgroundColor: Color(0xFF5E35B1),
                            textStyle: TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLines,
    );
  }
}
