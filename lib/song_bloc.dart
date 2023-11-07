import 'package:flutter_bloc/flutter_bloc.dart';
import 'song_event.dart';
import 'song_state.dart';
import 'spotify_service.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final SpotifyService _spotifyService;

  SongBloc(this._spotifyService) : super(SongsInitial()) {
    on<SearchSongsEvent>((event, emit) async {
      emit(SongsLoading());
      try {
        final songs = await _spotifyService.searchSongs(event.query);
        if (songs.isNotEmpty) {
          emit(SongsLoaded(songs));
        } else {
          emit(SongsError('No se encontraron canciones.'));
        }
      } catch (e) {
        emit(SongsError('Error al buscar canciones: ${e.toString()}'));
      }
    });
  }
}
