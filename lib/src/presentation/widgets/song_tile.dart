import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/song.dart';
import '../../state/playback_controller.dart';

class SongTile extends ConsumerWidget {
  const SongTile({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(playbackControllerProvider.notifier);
    return ListTile(
      title: Text(song.title),
      subtitle: Text(song.artist),
      leading: Icon(song.source == SongSource.offline ? Icons.offline_pin : Icons.cloud_queue),
      trailing: song.cached ? const Icon(Icons.download_done, size: 18) : null,
      onTap: () => ctrl.playSong(song),
    );
  }
}
