import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStoryScreen extends StatefulWidget {
  @override
  _AddStoryScreenState createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String ageGroup = '3-6';
  String type = 'Prophet';
  String name = '';
  String story = '';
  String imageUrl = '';

  Future<void> uploadData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String collectionName =
          type.toLowerCase() + ageGroup.replaceAll('-', 'to');
      String documentId = name.toLowerCase().replaceAll(' ', '_') +
          '_' +
          DateTime.now().millisecondsSinceEpoch.toString();

      try {
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(documentId)
            .set({
          'name': name,
          'story': story,
          'image': imageUrl, // Use the image URL directly
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your story has been added successfully!'),
            backgroundColor: Colors.green,
          ),
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
              Text(
                'Select Age Group',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField(
                value: ageGroup,
                onChanged: (String? newValue) {
                  setState(() {
                    ageGroup = newValue!;
                  });
                },
                items: <String>['3-6', '7-10', '11-12']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Select Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField(
                value: type,
                onChanged: (String? newValue) {
                  setState(() {
                    type = newValue!;
                  });
                },
                items: <String>['Prophet', 'Saint']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter the name (e.g., Hazrat Adam Alaihis Salam)',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSaved: (value) {
                  name = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter the story',
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
                  hintText: 'Enter image URL',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSaved: (value) {
                  imageUrl = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32), // Add space before the button
              Center(
                child: ElevatedButton(
                  onPressed: uploadData,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    backgroundColor: Color(0xFF6E62C9), // Button color
                    textStyle: TextStyle(fontSize: 18), // Increase text size
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
