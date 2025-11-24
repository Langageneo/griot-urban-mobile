import 'package:flutter/material.dart';
import 'package:griot_urban_app/constants/colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContentDetailScreen extends StatefulWidget {
  final Map<String, dynamic> content;
  final String category;

  const ContentDetailScreen({
    Key? key,
    required this.content,
    required this.category,
  }) : super(key: key);

  @override
  _ContentDetailScreenState createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _showHalo = true;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/ninho_himra.mp3')); // Fichier à ajouter dans assets/sounds/
      setState(() => _isPlaying = true);
      await Future.delayed(const Duration(seconds: 5)); // Durée de l'extrait
      setState(() => _isPlaying = false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur audio: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final haloColor = _getHaloColor(widget.category);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image avec halo animé
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(
                        color: haloColor.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: CachedNetworkImage(
                      imageUrl: widget.content['imageUrl'] ?? widget.content['thumbnail'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[800]),
                      errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
                    ),
                  ),
                ),
                if (_showHalo)
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: haloColor,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: haloColor.withOpacity(0.7),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Titre et description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.content['title'] ?? widget.content['channelTitle'] ?? 'Contenu',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildCategoryTag(widget.category),
                      const SizedBox(width: 8),
                      Text(
                        widget.content['publishedAt'] != null
                            ? 'Publié le ${DateTime.parse(widget.content['publishedAt']).toLocal().toString().split(' ')[0]}'
                            : 'Contenu récent',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.content['description'] ?? 'Découvrez le contenu exclusif de ${widget.content['channelTitle']}',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bouton pour jouer l'extrait sonore
                  GestureDetector(
                    onTap: () {
                      _playSound();
                      setState(() => _showHalo = !_showHalo);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        gradient: AppColors.buttonGradient,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: haloColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isPlaying ? Icons.stop : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isPlaying ? 'STOP' : 'JOUER L\'EXTRAIT',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Section commentaires (simulée)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'COMMENTAIRES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ...List.generate(3, (index) => _buildCommentTile()),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTag(String category) {
    Color color;
    String label;

    switch (category) {
      case 'artist':
        color = AppColors.artistHalo;
        label = 'ARTISTE';
        break;
      case 'media':
        color = AppColors.mediaHalo;
        label = 'MÉDIA';
        break;
      case 'influenceur':
        color = AppColors.influenceurHalo;
        label = 'INFLUENCEUR';
        break;
      default:
        color = Colors.grey;
        label = 'CONTENU';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCommentTile() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
      ),
      title: const Text(
        'Utilisateur123',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'Ce contenu est trop puissant ! 🔥',
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Icon(Icons.favorite_border, color: Colors.grey[400]),
    );
  }

  Color _getHaloColor(String category) {
    switch (category) {
      case 'artist': return AppColors.artistHalo;
      case 'media': return AppColors.mediaHalo;
      case 'influenceur': return AppColors.influenceurHalo;
      default: return AppColors.secondary;
    }
  }
}
