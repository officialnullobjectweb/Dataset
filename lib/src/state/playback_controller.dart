import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/song.dart';
import '../services/mock_data.dart';

class PlaybackState {
  const PlaybackState({
    this.current,
    this.isPlaying = false,
    this.sleepTimer,
    this.position = Duration.zero,
  });

  final Song? current;
  final bool isPlaying;
  final Duration? sleepTimer;
  final Duration position;

  PlaybackState copyWith({
    Song? current,
    bool? isPlaying,
    Duration? sleepTimer,
    bool clearTimer = false,
    Duration? position,
  }) {
    return PlaybackState(
      current: current ?? this.current,
      isPlaying: isPlaying ?? this.isPlaying,
      sleepTimer: clearTimer ? null : (sleepTimer ?? this.sleepTimer),
      position: position ?? this.position,
    );
  }
}

class PlaybackController extends StateNotifier<PlaybackState> {
  PlaybackController() : super(PlaybackState(current: demoLibrary.first));

  void playSong(Song song) => state = state.copyWith(current: song, isPlaying: true);
  void toggle() => state = state.copyWith(isPlaying: !state.isPlaying);
  void setSleepTimer(Duration value) => state = state.copyWith(sleepTimer: value);
  void clearSleepTimer() => state = state.copyWith(clearTimer: true);
}

final playbackControllerProvider =
    StateNotifierProvider<PlaybackController, PlaybackState>((ref) => PlaybackController());
