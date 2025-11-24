import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HaloCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Color haloColor;
  final String category;
  final VoidCallback onTap;
  final bool isSelected;

  const HaloCard({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.haloColor,
    required this.category,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteneur principal avec ombre
          Container(
            width: 160,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: haloColor.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: isSelected ? 3 : 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 180,
                width: 160,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ),

          // Halo lumineux (effet glow)
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: haloColor,
                  width: isSelected ? 3 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: haloColor.withOpacity(0.6),
                    blurRadius: isSelected ? 20 : 10,
                    spreadRadius: isSelected ? 2 : 1,
                  ),
                ],
              ),
            ),
          ),

          // Contenu (titre + icône catégorie)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: 'Urbanist',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildCategoryIcon(category),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(String category) {
    IconData icon;
    Color color;

    switch (category) {
      case 'artist':
        icon = Icons.mic;
        color = AppColors.artistHalo;
        break;
      case 'media':
        icon = Icons.newspaper;
        color = AppColors.mediaHalo;
        break;
      case 'influenceur':
        icon = Icons.star;
        color = AppColors.influenceurHalo;
        break;
      default:
        icon = Icons.music_note;
        color = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }
}
