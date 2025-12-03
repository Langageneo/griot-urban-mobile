// Chemin: lib/models/video_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart'; // Ce fichier sera généré, ne t'inquiète pas

@JsonSerializable(createToJson: false)
class VideoModel {
  final String videoId;
  final String title;
  final String thumbnailUrl;

  VideoModel({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
  });

  // Cette 'factory' transforme le JSON reçu de l'API en notre objet VideoModel.
  // C'est ici qu'on centralise la logique pour éviter les erreurs.
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoId: json['id']?['videoId'] ?? json['id'] as String,
      title: json['snippet']?['title'] as String? ?? 'Titre non disponible',
      thumbnailUrl: json['snippet']?['thumbnails']?['high']?['url'] as String? ?? '',
    );
  }
}
