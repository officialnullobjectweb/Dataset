import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shortcuts = [
      ('😀 Happy', Icons.sentiment_very_satisfied),
      ('💪 Workout', Icons.fitness_center),
      ('🌙 Night Drive', Icons.nightlight),
      ('📚 Study', Icons.menu_book),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('BeatFlow', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text('Smart mixes and mood shortcuts',
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: shortcuts
              .map((s) => ActionChip(
                    label: Text(s.$1),
                    avatar: Icon(s.$2, size: 16),
                    onPressed: () {},
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),
        const Card(
          child: ListTile(
            leading: Icon(Icons.auto_awesome),
            title: Text('Daily Mix'),
            subtitle: Text('Auto-categorized by mood, language, and energy.'),
          ),
        ),
      ],
    );
  }
}
