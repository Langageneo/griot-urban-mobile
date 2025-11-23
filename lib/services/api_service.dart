import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _baseUrl = dotenv.get('API_BASE_URL', fallback: 'http://localhost:5000/api');

  // Récupérer les vidéos YouTube
  static Future<List<dynamic>> fetchYoutubeVideos(String channelId) async {
    final response = await http.get(Uri.parse('$_baseUrl/youtube/channel/$channelId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load YouTube videos');
    }
  }

  // Récupérer les tweets
  static Future<List<dynamic>> fetchTweets(String username) async {
    final response = await http.get(Uri.parse('$_baseUrl/twitter/tweets/$username'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tweets');
    }
  }

  // Récupérer les posts Instagram
  static Future<List<dynamic>> fetchInstagramPosts(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/instagram/posts/$userId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Instagram posts');
    }
  }
}
