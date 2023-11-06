import 'package:flutter/material.dart';
import 'package:spotify_project/detail_screen.dart';
import 'spotify_service.dart';

class ArtistScreen extends StatefulWidget {
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  List<dynamic> artists = [];
  final SpotifyService _spotifyService = SpotifyService();
  final TextEditingController _searchController = TextEditingController();

  _searchArtists() async {
    if (_searchController.text.isNotEmpty) {
      final results = await _spotifyService.searchArtists(_searchController.text);
      if (results.isNotEmpty) {
        setState(() {
          artists = results;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Artistas')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar Artista',
                    border: InputBorder.none,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _searchArtists,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: artists.isEmpty
                  ? Center(child: Text('Busca artistas para ver resultados.'))
                  : ListView.builder(
                      itemCount: artists.length,
                      itemBuilder: (context, index) {
                        var artist = artists[index];
                        return ListTile(
                          title: Text(artist['name']),
                          leading: artist['images'].isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(artist['images'][0]['url']),
                                )
                              : CircleAvatar(
                                  child: Icon(Icons.music_note),
                                ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(item: artist, type: "Artista"),
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

class ArtistDetailScreen extends StatelessWidget {
  final dynamic artist;

  ArtistDetailScreen({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(artist['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: artist['images'].isNotEmpty
                  ? NetworkImage(artist['images'][0]['url'])
                  : null,
              child: artist['images'].isEmpty ? Icon(Icons.music_note, size: 50) : null,
            ),
            SizedBox(height: 20),
            Text(
              artist['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              artist['genres'].join(', '),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
