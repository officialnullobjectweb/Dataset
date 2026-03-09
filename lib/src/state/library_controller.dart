import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/song.dart';
import '../services/library_service.dart';

final libraryServiceProvider = Provider<LibraryService>((ref) => LibraryService());

final unifiedSearchProvider = FutureProvider.family<List<Song>, String>((ref, query) async {
  final service = ref.watch(libraryServiceProvider);
  return service.searchUnified(query);
});

final localLibraryProvider = FutureProvider<List<Song>>((ref) async {
  final service = ref.watch(libraryServiceProvider);
  return service.scanLocalLibrary();
});
