# BeatFlow (Flutter App Scaffold)

This repository now contains a full Flutter application scaffold built from the `docs/PRD_BeatFlow.md` requirements.

## Included
- Flutter app entrypoint and app shell
- GoRouter-based bottom navigation (Home, Search, Library, Sync Room, Profile)
- Riverpod state for theme, playback, and library search
- Unified search mock (offline + online sources)
- Local library scan mock
- Mini player with play/pause
- Sleep timer settings placeholder
- Sync room, premium, and feature module placeholders aligned to PRD phases

## Run
1. Install Flutter SDK
2. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Note
This is a production-oriented scaffold and architecture baseline. Integrations for streaming APIs, lyrics providers, equalizer DSP, stem separation, and sync backend are intentionally stubbed/mocked for incremental delivery.
