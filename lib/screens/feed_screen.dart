import 'package:flutter/material.dart';
import 'package:griot_urban_app/constants/colors.dart';
import 'package:griot_urban_app/services/api_service.dart';
import 'package:griot_urban_app/widgets/halo_card.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();
  Map<String, dynamic>? _selectedContent;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _playSound(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
      setState(() => _isPlaying = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur audio: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Griot Urban', style: TextStyle(fontFamily: 'Urbanist', fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Section Artistes
            _buildSectionTitle("ARTISTES 🎤", AppColors.artistHalo),
            FutureBuilder(
              future: ApiService.fetchYoutubeChannels('artist'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return _buildHorizontalList(snapshot.data!, 'artist');
              },
            ),
            const SizedBox(height: 20),

            // Section Médias
            _buildSectionTitle("MÉDIAS 📰", AppColors.mediaHalo),
            FutureBuilder(
              future: ApiService.fetchYoutubeChannels('media'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return _buildHorizontalList(snapshot.data!, 'media');
              },
            ),
            const SizedBox(height: 20),

            // Section Influenceurs
            _buildSectionTitle("INFLUENCEURS 🌟", AppColors.influenceurHalo),
            FutureBuilder(
              future: ApiService.fetchYoutubeChannels('influenceur'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return _buildHorizontalList(snapshot.data!, 'influenceur');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist',
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward, color: color, size: 18),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(List<dynamic> items, String category) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: HaloCard(
              id: item['id'],
              title: item['title'] ?? item['channelTitle'],
              imageUrl: item['thumbnail'] ?? 'https://via.placeholder.com/500',
              haloColor: Color(int.parse(item['haloColor'].replaceAll('#', '0xff'))),
              category: category,
              onTap: () {
                _playSound('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'); // Remplacer par l'extrait "Ninho feat HIMRA"
                setState(() => _selectedContent = item);
              },
              isSelected: _selectedContent?.['id'] == item['id'],
            ),
          );
        },
      ),
    );
  }
}
