import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoCard extends StatelessWidget {
  final dynamic video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: video['snippet']['thumbnails']['high']['url'],
            width: 150,
            height: 100,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              video['snippet']['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
