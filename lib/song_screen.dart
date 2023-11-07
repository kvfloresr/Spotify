import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/spotify_service.dart';
import 'detail_screen.dart';
import 'song_bloc.dart'; // Asegúrate de tener este archivo
import 'song_event.dart'; // y este
import 'song_state.dart'; // y también este

class SongScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SongBloc(SpotifyService()),
      child: SongView(),
    );
  }
}

class SongView extends StatelessWidget {
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
                  onChanged: (query) {
                    BlocProvider.of<SongBloc>(context).add(SearchSongsEvent(query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar Canción',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<SongBloc, SongState>(
                builder: (context, state) {
                  if (state is SongsInitial) {
                    return Center(child: Text('Busca canciones para ver resultados.'));
                  } else if (state is SongsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SongsLoaded) {
                    return ListView.builder(
                      itemCount: state.songs.length,
                      itemBuilder: (context, index) {
                        var song = state.songs[index];
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
                    );
                  } else if (state is SongsError) {
                    return Center(child: Text(state.message));
                  }
                  return Container(); 
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
