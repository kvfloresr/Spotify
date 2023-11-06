import 'package:flutter/material.dart';
import 'spotify_service.dart';
import 'detail_screen.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final SpotifyService _spotifyService = SpotifyService();
  List playlists = [];

  _searchPlaylists(String query) async {
    final results = await _spotifyService.searchPlaylists(query);
    if (results.isNotEmpty) {
      setState(() {
        playlists = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Listas de Reproducción')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  onChanged: _searchPlaylists,
                  decoration: InputDecoration(
                    hintText: 'Buscar Lista de Reproducción',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: playlists.isEmpty
                  ? Center(child: Text('Busca listas de reproducción para ver resultados.'))
                  : ListView.builder(
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        var playlist = playlists[index];
                        return ListTile(
                          title: Text(playlist['name']),
                          leading: playlist['images'].isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(playlist['images'][0]['url']),
                                )
                              : CircleAvatar(
                                  child: Icon(Icons.music_note),
                                ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(item: playlist, type: "Playlist"),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
