import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  final String story;
  final List<String> imageUrls;

  const StoryScreen({super.key, required this.story, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Story')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: _buildStoryContent(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStoryContent() {
    List<Widget> content = [];
    int imageCount = imageUrls.length;

    List<String> storyParts = _splitStoryIntoParts(story, imageCount);

    for (int i = 0; i < imageCount; i++) {
      if (imageUrls[i].isNotEmpty) {
        content.add(Image.network(imageUrls[i]));
        content.add(SizedBox(height: 16));
      }

      if (i < storyParts.length) {
        content.add(Text(storyParts[i]));
        content.add(SizedBox(height: 16));
      }
    }

    if (imageCount == 0) {
      content.add(Text(story));
    }

    return content;
  }

  List<String> _splitStoryIntoParts(String story, int numberOfParts) {
    List<String> parts = [];
    int partLength = (story.length / numberOfParts).ceil();

    for (int i = 0; i < numberOfParts; i++) {
      int start = i * partLength;
      int end = start + partLength;

      if (start < story.length) {
        parts.add(
            story.substring(start, end > story.length ? story.length : end));
      }
    }
    return parts;
  }
}
