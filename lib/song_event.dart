abstract class SongEvent {}

class SearchSongsEvent extends SongEvent {
  final String query;

  SearchSongsEvent(this.query);
}
