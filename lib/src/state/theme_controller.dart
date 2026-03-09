import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState {
  const ThemeState({
    required this.mode,
    required this.seedColor,
  });

  final ThemeMode mode;
  final Color seedColor;

  ThemeState copyWith({ThemeMode? mode, Color? seedColor}) {
    return ThemeState(
      mode: mode ?? this.mode,
      seedColor: seedColor ?? this.seedColor,
    );
  }
}

class ThemeController extends StateNotifier<ThemeState> {
  ThemeController()
      : super(const ThemeState(mode: ThemeMode.system, seedColor: Colors.deepPurple));

  void setMode(ThemeMode mode) => state = state.copyWith(mode: mode);
  void setSeedColor(Color color) => state = state.copyWith(seedColor: color);
}

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeState>((ref) => ThemeController());
