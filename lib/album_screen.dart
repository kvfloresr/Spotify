import 'package:flutter/material.dart';
import 'spotify_service.dart';
import 'detail_screen.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final SpotifyService _spotifyService = SpotifyService();
  List albums = [];

  _searchAlbums(String query) async {
    final results = await _spotifyService.searchAlbums(query);
    if (results.isNotEmpty) {
      setState(() {
        albums = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Álbumes')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  onChanged: _searchAlbums,
                  decoration: InputDecoration(
                    hintText: 'Buscar Álbum',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: albums.isEmpty
                  ? Center(child: Text('Busca álbumes para ver resultados.'))
                  : ListView.builder(
                      itemCount: albums.length,
                      itemBuilder: (context, index) {
                        var album = albums[index];
                        return ListTile(
                          title: Text(album['name']),
                          leading: album['images'].isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(album['images'][0]['url']),
                                )
                              : CircleAvatar(
                                  child: Icon(Icons.music_note),
                                ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(item: album, type: "Álbum"),
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
