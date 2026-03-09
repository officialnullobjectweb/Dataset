import '../domain/models/song.dart';

const demoLibrary = <Song>[
  Song(
    id: '1',
    title: 'Khoya Sa',
    artist: 'Anuv Jain',
    duration: Duration(minutes: 3, seconds: 42),
    source: SongSource.offline,
    album: 'Home Sessions',
    cached: true,
  ),
  Song(
    id: '2',
    title: 'Raatan Lambiyan',
    artist: 'Asees Kaur',
    duration: Duration(minutes: 3, seconds: 50),
    source: SongSource.online,
  ),
  Song(
    id: '3',
    title: 'Kesariya',
    artist: 'Arijit Singh',
    duration: Duration(minutes: 4, seconds: 28),
    source: SongSource.online,
    cached: true,
  ),
  Song(
    id: '4',
    title: 'Amplifier',
    artist: 'Imran Khan',
    duration: Duration(minutes: 3, seconds: 56),
    source: SongSource.offline,
  ),
];
