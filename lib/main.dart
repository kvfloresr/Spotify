import 'package:flutter/material.dart';
import 'package:spotify_project/firebase_options.dart';
import 'album_screen.dart';
import 'playlist_screen.dart';
import 'artist_screen.dart';
import 'song_screen.dart';
import 'favorites_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify API',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        hintColor: Colors.white,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/spotifyy.png', height: 80.0), 
            SizedBox(height: 30),
            Text(
              "Spotify API by Karen Flores",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Explora la API de Spotify.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 50),
            _buildButton(
              context,
              text: 'Ver Álbumes',
              icon: FontAwesomeIcons.compactDisc,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumScreen())),
            ),
            SizedBox(height: 20),
            _buildButton(
              context,
              text: 'Ver Listas de Reproducción',
              icon: FontAwesomeIcons.music,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistScreen())),
            ),
            SizedBox(height: 20),
            _buildButton(
              context,
              text: 'Ver Artistas',
              icon: FontAwesomeIcons.search,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistScreen())),
            ),
            SizedBox(height: 20),
            _buildButton(
              context,
              text: 'Ver Canciones',
              icon: FontAwesomeIcons.music,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SongScreen())), 
            ),
            SizedBox(height: 20),
            _buildButton(
              context,
              text: 'Ver Canciones Favoritas',
              icon: FontAwesomeIcons.heart,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()),
  ),
),

          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required String text, required IconData icon, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        minimumSize: Size(double.infinity, 50),
      ),
      icon: FaIcon(icon, color: Colors.white),
      label: Text(text, style: TextStyle(fontSize: 18.0)),
      onPressed: onPressed,
    );
  }
}
