import 'song.dart';

class Playlist {
  const Playlist({
    required this.id,
    required this.name,
    required this.songs,
    this.isSmart = false,
  });

  final String id;
  final String name;
  final List<Song> songs;
  final bool isSmart;
}
