import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canciones Favoritas')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final favorites = snapshot.data!.docs;

          if (favorites.isEmpty) {
            return Center(child: Text('No tienes canciones favoritas.'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index].data() as Map<String, dynamic>;
                if (favorite == null) {
                return SizedBox.shrink(); 
              }

              final album = favorite['album'] as Map<String, dynamic>?;

              final albumName = album?['name']?? 'Nombre del albúm no disponible';
              final albumImages = album?['images'] as List<dynamic>?;


              final artists = album?['artists'] as List<dynamic>?;

              final artist = artists?[0] as Map<String, dynamic>?;


              final artistName = artist?['name'] ?? 'No disponible';

              final durationMs = favorite['duration_ms'] ?? 0;

              return ListTile(
                title: Text(albumName),
                subtitle: Text(artistName),
                leading: albumImages != null && albumImages.isNotEmpty
                    ? Image.network(albumImages[0]['url'])
                    : Icon(Icons.music_note, size: 50),
                trailing: Text('$durationMs ms'),
              );
            },
          );
        },
      ),
    );
  }
}
