import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  final List<Map<String, String>> songSuggestions = [
    {
      'name': 'Hello - Adele',
      'image': 'https://i.scdn.co/image/ab67616d0000b27347ce408fb4926d69da6713c2',
    },
    {
      'name': 'Vampire - Olivia Rodrigo',
      'image': 'https://i.scdn.co/image/ab67616d0000b273e85259a1cae29a8d91f2093d',
    },
    {
      'name': 'Cliché - Mxmtoon',
      'image': 'https://i.scdn.co/image/ab67616d0000b27343def9298e39310a2033b8d1',
    },
    {
      'name': 'The Scients - Coldplay',
      'image': 'https://i.scdn.co/image/ab67616d0000b273de09e02aa7febf30b7c02d82',
    },
    {
      'name': 'The Scients - Coldplay',
      'image': 'https://i.scdn.co/image/ab67616d0000b2735675e83f707f1d7271e5cf8a',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.asset('assets/spotifyy.png', height: 55.0),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CarouselSlider.builder(
              itemCount: songSuggestions.length, 
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(songSuggestions[itemIndex]['image']!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    songSuggestions[itemIndex]['name']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(150, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16/9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            SizedBox(height: 30),
            // Grid de botones
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 8.0 / 9.0,
              children: [
                _buildCard(context, 'Álbumes', FontAwesomeIcons.compactDisc, () => Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumScreen()))),
                _buildCard(context, 'Listas de Reproducción', FontAwesomeIcons.music, () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistScreen()))),
                _buildCard(context, 'Artistas', FontAwesomeIcons.userAstronaut, () => Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistScreen()))),
                _buildCard(context, 'Canciones', FontAwesomeIcons.headphonesAlt, () => Navigator.push(context, MaterialPageRoute(builder: (context) => SongScreen()))),
                _buildCard(context, 'Favoritos', FontAwesomeIcons.heart, () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}