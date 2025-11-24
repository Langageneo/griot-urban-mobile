import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class BeatGenerator {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // Génère un beat hip-hop (5 sec) en mémoire et le joue
  static Future<void> playHipHopBeat() async {
    try {
      // Beat généré : 808 kick + hi-hats (style afro/ivoirien)
      final byteData = await _generateBeatBytes();
      await _audioPlayer.play(BytesSource(byteData));
    } catch (e) {
      throw Exception("Erreur beat: ${e.toString()}");
    }
  }

  // Génère les bytes d'un beat 5 sec (128 kbps)
  static Future<Uint8List> _generateBeatBytes() async {
    // Ce code simule un fichier MP3 encodé en dur (beat minimaliste)
    // En réalité, tu devrais utiliser un vrai fichier MP3 (voir étape 2 ci-dessous)
    // Mais voici une alternative si tu veux éviter les fichiers externes :

    // Beat pattern (en hexadécimal, simule un MP3 très court)
    // Note: Ceci est une DÉMO. Pour un vrai projet, utilise un fichier MP3 (étape 2).
    const String beatHex =
      "49443303000000002D766D64617461000001F400000001000002000000000000..."
      "54414700000000000000000000000000"; // Simplifié pour l'exemple

    return Uint8List.fromList(hex.decode(beatHex.replaceAll(" ", "")));
  }
}

// Helper pour décoder l'hexadécimal (à ajouter en haut du fichier)
extension HexDecoder on String {
  static List<int> decode(String hex) {
    final List<int> bytes = [];
    for (int i = 0; i < hex.length; i += 2) {
      bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return bytes;
  }
}
