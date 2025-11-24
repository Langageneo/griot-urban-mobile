import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _apiUrl = dotenv.get('API_BASE_URL');

  // Récupère les chaînes YouTube par catégorie
  static Future<List<dynamic>> fetchYoutubeChannels(String category) async {
    final response = await http.get(Uri.parse('$_apiUrl/youtube/channels?category=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return category == 'artist'
          ? data['artists']
          : category == 'media'
              ? data['medias']
              : data['influenceurs'];
    } else {
      throw Exception('Failed to load channels');
    }
  }

  // Récupère les vidéos d'une chaîne YouTube
  static Future<List<dynamic>> fetchYoutubeVideos(String channelId) async {
    final response = await http.get(Uri.parse('$_apiUrl/youtube/channel/$channelId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load videos');
    }
  }

  // Récupère les posts Instagram
  static Future<List<dynamic>> fetchInstagramPosts(String username) async {
    final response = await http.get(Uri.parse('$_apiUrl/instagram/posts/$username'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Instagram posts');
    }
  }

  // Récupère les tweets
  static Future<List<dynamic>> fetchTweets(String username) async {
    final response = await http.get(Uri.parse('$_apiUrl/twitter/tweets/$username'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tweets');
    }
  }

  // Récupère les comptes Instagram
  static Future<Map<String, dynamic>> fetchInstagramAccounts() async {
    final response = await http.get(Uri.parse('$_apiUrl/instagram/accounts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Instagram accounts');
    }
  }

  // Récupère les comptes Twitter
  static Future<Map<String, dynamic>> fetchTwitterAccounts() async {
    final response = await http.get(Uri.parse('$_apiUrl/twitter/accounts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Twitter accounts');
    }
  }
}
