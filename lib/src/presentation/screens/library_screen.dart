import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/library_controller.dart';
import '../widgets/song_tile.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = ref.watch(localLibraryProvider);

    return local.when(
      data: (songs) => ListView(
        children: [
          const ListTile(
            title: Text('Local Library'),
            subtitle: Text('Scanned offline music files'),
          ),
          ...songs.map((song) => SongTile(song: song)),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Failed to load library: $e')),
    );
  }
}
