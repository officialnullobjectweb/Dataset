enum SongSource { offline, online }

class Song {
  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.source,
    this.album,
    this.albumArt,
    this.cached = false,
  });

  final String id;
  final String title;
  final String artist;
  final Duration duration;
  final SongSource source;
  final String? album;
  final String? albumArt;
  final bool cached;
}
