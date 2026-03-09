import 'dart:async';

import '../domain/models/song.dart';
import 'mock_data.dart';

class LibraryService {
  Future<List<Song>> scanLocalLibrary() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return demoLibrary.where((s) => s.source == SongSource.offline).toList();
  }

  Future<List<Song>> searchUnified(String query) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (query.trim().isEmpty) return demoLibrary;
    final q = query.toLowerCase();
    return demoLibrary
        .where((s) => s.title.toLowerCase().contains(q) || s.artist.toLowerCase().contains(q))
        .toList();
  }
}
