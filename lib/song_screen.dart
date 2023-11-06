import 'package:flutter/material.dart';
import 'spotify_service.dart';
import 'detail_screen.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  final SpotifyService _spotifyService = SpotifyService();
  List songs = [];

  _searchSongs(String query) async {
    final results = await _spotifyService.searchSongs(query);
    if (results.isNotEmpty) {
      setState(() {
        songs = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Canciones')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  onChanged: _searchSongs,
                  decoration: InputDecoration(
                    hintText: 'Buscar Canción',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: songs.isEmpty
                  ? Center(child: Text('Busca canciones para ver resultados.'))
                  : ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        var song = songs[index];
                        return ListTile(
                          title: Text(song['name']),
                          subtitle: Text(song['artists'][0]['name']),
                          leading: song['album']['images'].isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(song['album']['images'][0]['url']),
                                )
                              : CircleAvatar(
                                  child: Icon(Icons.music_note),
                                ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(item: song, type: "Track"),
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
