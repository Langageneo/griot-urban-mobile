import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _apiUrl = dotenv.get('API_BASE_URL');

  // NOUVEAU : Inscription
  static Future<Map<String, dynamic>> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)['msg'] ?? 'Erreur d\'inscription');
    }
  }

  // NOUVEAU : Connexion
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)['msg'] ?? 'Erreur de connexion');
    }
  }

  // EXISTANT : Récupérer les vidéos YouTube (à garder)
  static Future<List<dynamic>> fetchYoutubeVideos(String channelId) async {
    final response = await http.get(Uri.parse('$_apiUrl/youtube/channel/$channelId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load YouTube videos');
    }
  }

  // EXISTANT : Récupérer les tweets (à garder)
  static Future<List<dynamic>> fetchTweets(String username) async {
    final response = await http.get(Uri.parse('$_apiUrl/twitter/tweets/$username'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tweets');
    }
  }

  // EXISTANT : Récupérer les posts Instagram (à garder)
  static Future<List<dynamic>> fetchInstagramPosts(String userId) async {
    final response = await http.get(Uri.parse('$_apiUrl/instagram/posts/$userId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Instagram posts');
    }
  }
}
