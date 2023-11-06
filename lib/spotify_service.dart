import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  final String _clientID = 'e34cd3f2c45540e18b07cb5372425435';
  final String _clientSecret = '234401c6c2de4c8d94153b3a88ff00f1';

  Future<String?> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$_clientID:$_clientSecret'))}',
      },
      body: {
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      print('Error obteniendo el token: ${response.body}');
      return null;
    }
  }

  Future<List<dynamic>> searchAlbums(String query) async {
    final token = await _getAccessToken();
    if (token == null) return [];

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=album'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['albums']['items'] ?? [];
    } else {
      print('Error buscando albums: ${response.body}');
      return [];
    }
  }

  Future<List<dynamic>> searchPlaylists(String query) async {
    final token = await _getAccessToken();
    if (token == null) return [];

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=playlist'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['playlists']['items'] ?? [];
    } else {
      print('Error buscando playlists: ${response.body}');
      return [];
    }
  }

  Future<List<dynamic>> searchArtists(String query) async {
    final token = await _getAccessToken();
    if (token == null) return [];

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=artist'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['artists']['items'] ?? [];
    } else {
      print('Error searching artists: ${response.body}');
      return [];
    }
  }

  Future<Map<String, dynamic>> getAlbumDetails(String albumId) async {
    final token = await _getAccessToken();
    if (token == null) return {};

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/albums/$albumId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
    print('Error fetching album detalles: ${response.body}');
    return {};
    }
  }

  Future<Map<String, dynamic>> getPlaylistDetails(String playlistId) async {
    final token = await _getAccessToken();
    if (token == null) return {};

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/playlists/$playlistId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      print('Error fetching detalles del playlist: ${response.body}');
      return {};
    }
  }

  Future<Map<String, dynamic>> getArtistDetails(String artistId) async {
  final token = await _getAccessToken();
  if (token == null) return {};

  final response = await http.get(
    Uri.parse('https://api.spotify.com/v1/artists/$artistId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      print('Error fetching detalles del artista: ${response.body}');
      return {};
    }
  }

  Future<List<dynamic>> searchSongs(String query) async {
  final token = await _getAccessToken();
  if (token == null) return [];

  final response = await http.get(
    Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['tracks']['items'] ?? [];
  } else {
    print('Error buscando canciones: ${response.body}');
    return [];
    }
  }

  Future<Map<String, dynamic>> getTrackDetails(String trackId) async {
  final token = await _getAccessToken();
  if (token == null) return {};

  final response = await http.get(
    Uri.parse('https://api.spotify.com/v1/tracks/$trackId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    print('Error fetching track details: ${response.body}');
    return {};
  }
}


}

