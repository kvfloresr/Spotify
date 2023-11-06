import 'package:flutter/material.dart';
import 'spotify_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailScreen extends StatefulWidget {
  final dynamic item;
  final String type;

  DetailScreen({required this.item, required this.type});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic>? details;
  final SpotifyService _spotifyService = SpotifyService();

  @override
  void initState() {
    super.initState();
    if (widget.type == "Álbum") {
      _fetchAlbumDetails();
    } else if (widget.type == "Artista") {
      _fetchArtistDetails();
    } else if (widget.type == "Playlist") {
      _fetchPlaylistDetails();
    } else if (widget.type == "Track") {
      _fetchTrackDetails();
    }
  }

  _fetchAlbumDetails() async {
    final detailData = await _spotifyService.getAlbumDetails(widget.item['id']);
    setState(() {
      details = detailData;
    });
  }

  _fetchArtistDetails() async {
    final detailData =
        await _spotifyService.getArtistDetails(widget.item['id']);
    setState(() {
      details = detailData;
    });
  }

  _fetchPlaylistDetails() async {
    final detailData =
        await _spotifyService.getPlaylistDetails(widget.item['id']);
    setState(() {
      details = detailData;
    });
  }

  _fetchTrackDetails() async {
    final detailData = await _spotifyService.getTrackDetails(widget.item['id']);
    setState(() {
      details = detailData;
    });
  }

  void _addToFavorites() async {
    final CollectionReference favorites =
        FirebaseFirestore.instance.collection('favorites');
    await favorites.doc(widget.item['name']).set(widget.item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Canción agregada a favoritos'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: details == null
            ? Center(child: CircularProgressIndicator())
            : Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: (widget.type == "Track" &&
                              widget.item['album'] != null &&
                              widget.item['album']['images'].isNotEmpty)
                          ? NetworkImage(
                              widget.item['album']['images'][0]['url'])
                          : (widget.item['images'] != null &&
                                  widget.item['images'].isNotEmpty)
                              ? NetworkImage(widget.item['images'][0]['url'])
                              : null,
                      child: (widget.type == "Track" &&
                              widget.item['album'] != null &&
                              widget.item['album']['images'].isNotEmpty)
                          ? null
                          : (widget.item['images'] != null &&
                                  widget.item['images'].isNotEmpty)
                              ? null
                              : Icon(Icons.music_note, size: 50),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.item['name'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    if (widget.type == "Álbum") ...[
                      SizedBox(height: 10),
                      Text('Artista: ${details!['artists'][0]['name']}'),
                      SizedBox(height: 10),
                      Text('Total Tracks: ${details!['tracks']['total']}'),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: details!['tracks']['items'].length,
                          itemBuilder: (context, index) {
                            var track = details!['tracks']['items'][index];
                            return ListTile(
                              title: Text(track['name']),
                              subtitle: Text(
                                  '${track['duration_ms'] ~/ 60000}:${(track['duration_ms'] % 60000) ~/ 1000}'),
                            );
                          },
                        ),
                      ),
                    ],
                    if (widget.type == "Artista") ...[
                      SizedBox(height: 10),
                      Text('Followers: ${details!['followers']['total']}'),
                      SizedBox(height: 10),
                      Text('Popularity: ${details!['popularity']}'),
                      SizedBox(height: 10),
                      Text('Genres: ${details!['genres'].join(', ')}'),
                    ],
                    if (widget.type == "Playlist") ...[
                      SizedBox(height: 10),
                      Text(
                          'Propietario: ${details!['owner']['display_name']}'),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: details!['tracks']['items'].length,
                          itemBuilder: (context, index) {
                            var track =
                                details!['tracks']['items'][index]['track'];
                            return ListTile(
                              title: Text(track['name']),
                              subtitle: Text(
                                  '${track['artists'][0]['name']} - ${track['duration_ms'] ~/ 60000}:${(track['duration_ms'] % 60000) ~/ 1000}'),
                            );
                          },
                        ),
                      ),
                    ],
                    if (widget.type == "Track") ...[
                      SizedBox(height: 10),
                      Text('Canción: ${details!['name']}'),
                      SizedBox(height: 10),
                      Text('Artista: ${details!['artists'][0]['name']}'),
                      SizedBox(height: 10),
                      Text('Álbum: ${details!['album']['name']}'),
                      SizedBox(height: 10),
                      Text(
                          'Duración: ${details!['duration_ms'] ~/ 60000}:${(details!['duration_ms'] % 60000) ~/ 1000}'),
                    ],
                    ElevatedButton(
                      onPressed: _addToFavorites,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Agregar a favoritos'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
