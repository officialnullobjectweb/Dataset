import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/playback_controller.dart';
import '../../state/theme_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);
    final themeCtrl = ref.read(themeControllerProvider.notifier);
    final playback = ref.watch(playbackControllerProvider);
    final playbackCtrl = ref.read(playbackControllerProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Settings & Premium', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        DropdownButtonFormField<ThemeMode>(
          value: themeState.mode,
          decoration: const InputDecoration(labelText: 'Theme mode'),
          items: const [
            DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
            DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
            DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
          ],
          onChanged: (mode) {
            if (mode != null) themeCtrl.setMode(mode);
          },
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Sleep timer (minutes)'),
          subtitle: Text(playback.sleepTimer?.inMinutes.toString() ?? 'Off'),
          trailing: Wrap(
            spacing: 8,
            children: [
              TextButton(
                onPressed: () => playbackCtrl.setSleepTimer(const Duration(minutes: 30)),
                child: const Text('30m'),
              ),
              TextButton(
                onPressed: playbackCtrl.clearSleepTimer,
                child: const Text('Clear'),
              ),
            ],
          ),
        ),
        const Divider(),
        const ListTile(
          title: Text('Equalizer / Lyrics / Visualizer'),
          subtitle: Text('Feature modules scaffolded for phased implementation.'),
        ),
      ],
    );
  }
}
