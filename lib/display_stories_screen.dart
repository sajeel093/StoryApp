import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  final String story;
  final String imageUrl;

  const StoryScreen({super.key, required this.story, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Story')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (imageUrl.isNotEmpty) Image.network(imageUrl),
              SizedBox(height: 16),
              Text(story),
            ],
          ),
        ),
      ),
    );
  }
}
