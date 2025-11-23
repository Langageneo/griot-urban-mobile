import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFF6B35); // Orange (masque africain)
  static const secondary = Color(0xFF4A90E2); // Bleu (halo)
  static const background = Color(0xFFF5F5F5); // Fond clair
  static const darkBackground = Color(0xFF121212); // Fond sombre
  static const text = Color(0xFF333333); // Texte clair
  static const darkText = Color(0xFFFFFFFF); // Texte sombre
  static const error = Color(0xFFE74C3C); // Rouge erreur
  static const success = Color(0xFF2ECC71); // Vert succès

  // Thème sombre/clair
  static const lightTheme = {
    'background': background,
    'text': text,
  };
  static const darkTheme = {
    'background': darkBackground,
    'text': darkText,
  };
}
