import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GriotLogo extends StatelessWidget {
  final double size;
  final bool withAnimation;

  const GriotLogo({
    Key? key,
    this.size = 150,
    this.withAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Effet de glow (halo bleu)
            if (withAnimation)
              Container(
                width: size + 20,
                height: size + 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90E2).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),

            // Conteneur principal avec dégradé
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A1A2E), Color(0xFF2D2D4A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(size * 0.2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.string(
                  '''<!-- SVG Masque Africain + Halo (optimisé) -->
<svg viewBox="0 0 100 100" width="100%" height="100%">
  <!-- Halo arrière (bleu électrique) -->
  <circle cx="50" cy="50" r="45" fill="none" stroke="url(#haloGradient)" stroke-width="3" stroke-dasharray="5,2"/>

  <!-- Masque africain stylisé -->
  <path d="M50 10C25 10 10 25 10 50s15 40 40 40 40-40 15-25-15-25zm0-5c18.5 0 35 14.5 35 35s-16.5 35-35 35S15 68.5 15 50 31.5 15 50 15z"
        fill="url(#maskGradient)"
        stroke="#00F5FF"
        stroke-width="1.5"/>

  <!-- Yeux (style urbain) -->
  <circle cx="35" cy="40" r="5" fill="#4A90E2"/>
  <circle cx="65" cy="40" r="5" fill="#4A90E2"/>

  <!-- Bouche (sourire dynamique) -->
  <path d="M30 70q20-10 40 0" stroke="#00F5FF" stroke-width="2" fill="none"/>

  <!-- Dégradés -->
  <defs>
    <linearGradient id="haloGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#4A90E2"/>
      <stop offset="100%" stop-color="#00F5FF"/>
    </linearGradient>
    <linearGradient id="maskGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#2D2D4A"/>
      <stop offset="50%" stop-color="#1A1A2E"/>
      <stop offset="100%" stop-color="#4A90E2"/>
    </linearGradient>
  </defs>
</svg>
''',
                  width: size * 0.6,
                  height: size * 0.6,
                ),
              ),
            ),

            // Texte "Griot Urban" (optionnel)
            if (size > 100)
              Positioned(
                bottom: 10,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Color(0xFF00F5FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'Griot Urban',
                    style: TextStyle(
                      fontSize: size * 0.15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Urbanist',
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
