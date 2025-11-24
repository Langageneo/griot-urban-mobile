import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales
  static const Color primary = Color(0xFF1A1A2E);
  static const Color secondary = Color(0xFF4A90E2);
  static const Color background = Color(0xFF0F0F1A);
  static const Color text = Color(0xFFFFFFFF);

  // Couleurs des halos par catégorie
  static const Color artistHalo = Color(0xFF4A90E2);      // Bleu électrique (artistes)
  static const Color mediaHalo = Color(0xFFFF6B35);       // Orange (médias)
  static const Color influenceurHalo = Color(0xFF2ECC71); // Vert (influenceurs)
  static const Color premiumHalo = Color(0xFFFFD700);    // Or (Rap Ivoire)

  // Dégradés pour les boutons
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF4A90E2), Color(0xFF1E3A8A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Couleurs pour les effets
  static const Color haloGlow = Color(0xFF00F5FF);         // Effet glow bleu
  static const Color error = Color(0xFFFF3333);
  static const Color success = Color(0xFF2ECC71);
}
