abstract class SongState {}

class SongsInitial extends SongState {}

class SongsLoading extends SongState {}

class SongsLoaded extends SongState {
  final List<dynamic> songs;

  SongsLoaded(this.songs);
}

class SongsError extends SongState {
  final String message;

  SongsError(this.message);
}
