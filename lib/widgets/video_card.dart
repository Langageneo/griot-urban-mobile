// Chemin: lib/widgets/video_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/video_model.dart'; // On importe notre nouveau modèle !

class VideoCard extends StatelessWidget {
  // On utilise notre modèle `VideoModel`. C'est plus sûr et plus clair !
  final VideoModel video;
  // On ajoute une fonction `onTap` pour rendre la carte interactive.
  final VoidCallback? onTap;

  const VideoCard({
    super.key,
    required this.video,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // InkWell détecte les clics et ajoute un effet visuel "d'encre".
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // Permet à l'image de respecter les coins arrondis de la carte.
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image de la miniature
            CachedNetworkImage(
              // Accès propre et sûr aux données grâce à notre modèle
              imageUrl: video.thumbnailUrl,
              height: 180,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 180,
                color: Colors.grey[800], // Thème sombre
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 180,
                color: Colors.grey[800],
                child: const Icon(Icons.broken_image, color: Colors.grey, size: 48),
              ),
            ),

            // Titre de la vidéo
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                video.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
