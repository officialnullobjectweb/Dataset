import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/theme_controller.dart';
import 'router.dart';

class BeatFlowApp extends ConsumerWidget {
  const BeatFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);

    ThemeData buildTheme(Brightness brightness) {
      return ThemeData(
        useMaterial3: true,
        brightness: brightness,
        colorSchemeSeed: theme.seedColor,
      );
    }

    return MaterialApp.router(
      title: 'BeatFlow',
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: theme.mode,
      routerConfig: appRouter,
    );
  }
}
