# Product Requirements Document — Flutter Music Player App

## 1. Product Overview

**Product Name:** (To be decided — working title: "BeatFlow")  
**Platform:** Flutter (iOS, Android, Desktop — cross-platform)  
**Type:** Hybrid Music Player (Offline + Online Streaming)  
**Target Audience:** Music lovers who want a premium, feature-rich experience without paying for multiple subscriptions  
**Vision:** A single music app that replaces Spotify, Apple Music, Shazam, and Karaoke apps combined — with deep personalization, sync, and AI-powered features.

## 2. Goals and Success Metrics

**Primary Goals**
- Deliver a seamless offline and online music experience in one app
- Provide premium features like lyrics sync, equalizer, karaoke, and AI categorization
- Enable real-time multi-device sync for group listening
- Support regional Indian languages and Hinglish content natively

**Success Metrics**
- App crash rate below 0.5%
- Song load time under 1.5 seconds (online), instant (offline)
- Lyrics sync accuracy within 200ms of audio
- User retention above 60% at Day 30
- Multi-device sync latency below 500ms

## 3. Feature Requirements

### Feature 1 — Offline and Online Music Playback

**Description**  
The app must handle both locally stored music files and online streaming from supported sources in a unified interface. The user should not feel a difference in experience between offline and online tracks.

**Requirements**
- Scan and index all local audio files on the device (MP3, FLAC, WAV, AAC, OGG, M4A)
- Support online streaming via integrated music APIs (YouTube Music API, JioSaavn API, or Spotify Web Playback SDK depending on licensing)
- Unified search bar that returns both local and online results simultaneously
- Visual badge on each song card indicating whether it is offline or online
- Seamless fallback — if an online song is cached, play cached version to save data
- Background playback with system media controls (lock screen, notification bar)
- Gapless playback between tracks
- Crossfade transition with adjustable duration (0 to 12 seconds)
- Sleep timer (discussed in Feature 6)
- Queue management — add to next, add to end, reorder, shuffle

**Flutter Packages**
- just_audio or audioplayers for local playback
- youtube_explode_dart or saavn dart wrapper for online streaming
- flutter_media_metadata for reading ID3 tags

### Feature 2 — Music Download Manager

**Description**  
Users can download any online song for offline use. The download manager handles queuing, progress tracking, retry on failure, and quality selection.

**Requirements**
- Download any individual song, album, or playlist in one tap
- Quality options: 96kbps, 128kbps, 256kbps, 320kbps, Lossless (FLAC where available)
- Background download even when app is minimized
- Download queue with progress bars per item
- Pause, resume, and cancel individual downloads
- Auto-download on WiFi only toggle in settings
- Downloaded songs auto-tagged with metadata, cover art, and lyrics
- Storage usage dashboard showing downloaded songs size, with bulk delete
- Downloaded songs appear in offline library automatically

**Flutter Packages**
- dio for HTTP downloading with progress stream
- flutter_downloader or background_fetch for background downloads
- path_provider for file storage

### Feature 3 — Equalizer

**Description**  
A fully functional audio equalizer with presets, custom band control, bass boost, and 3D surround sound effects.

**Requirements**
- 10-band parametric equalizer with frequency range 31Hz to 16kHz
- Visual equalizer graph that updates in real time as bands are adjusted
- Built-in presets: Normal, Rock, Pop, Jazz, Classical, Hip-Hop, Electronic, Bass Booster, Vocal Boost, Podcast, Lo-Fi
- User can save custom presets with a name
- Bass Boost slider (0 to 100%)
- Treble Boost slider
- Virtualizer / 3D Surround Sound toggle
- Loudness Enhancer
- Reverb / Room effect selector (Studio, Live Hall, Stage, Church)
- Auto EQ — app analyzes the song genre and auto-applies the best preset
- All EQ settings persist per playlist or globally based on user preference

**Flutter Packages**
- flutter_equalizer or native platform channel to Android AudioEffect API and iOS AVAudioEngine
- Custom painter for real-time EQ graph

### Feature 4 — Lyrics (Native Language + Hinglish, Synced, Animated)

**Description**  
Every song displays lyrics that scroll and highlight in sync with playback. Lyrics are available in the song's native language and in Hinglish (Hindi written in English romanized script). They auto-download silently when a song plays.

**Requirements**
- Auto-fetch lyrics on song start using LRC or TTML format from APIs (Musixmatch, LRCLIB, Genius, Gaana internal API)
- LRC time-coded lyrics sync with audio timestamp — active line highlights with smooth scroll
- Karaoke-style word-by-word highlight as audio progresses (character level timing where available)
- Language options per song: Original (native script — Hindi Devanagari, Punjabi Gurmukhi, English, Tamil etc.), Transliteration (Hinglish / Roman script), Translation (English translation of regional songs)
- User can toggle between these modes with a swipe or button tap during playback
- Animated lyrics background — lyrics float over the album art with blur, pulse on beat, or parallax scroll
- Lyrics font size adjustment
- If lyrics not available, show an animated waveform in the lyrics panel instead
- Lyrics saved locally after first fetch (no repeat download)
- User can report incorrect lyrics or manually edit them
- Lyrics panel can be fullscreen or half-screen card

**Flutter Packages**
- http or dio for Musixmatch / LRC API calls
- Lottie or rive for animation layers
- Custom scroll controller tied to AudioPlayer position stream

### Feature 5 — Music Visualizer and Beat Animations (Premium)

**Description**  
The app offers a set of premium real-time audio visualizer animations that react to music beats and frequencies. These are the main "wow factor" of the app.

**Requirements**
- Minimum 10 visualizer themes available
- Visualizer list includes:
  - Circular waveform (classic)
  - Particle explosion on beats
  - Galaxy / nebula flow with bass pulse
  - Neon bars equalizer
  - 3D cube rotation to tempo
  - Fire flame reactive (flame height tied to bass)
  - DNA helix with beat rotation
  - Rain drops on glass with ripples on beat
  - Vinyl record spinning with scratch animation
  - Aurora borealis flowing with treble
- Visualizer runs in background of Now Playing screen and optionally as a live wallpaper
- Beat detection using FFT (Fast Fourier Transform) analysis on audio stream
- Smooth 60fps animation locked to audio frequency data
- User can favorite specific visualizers
- All visualizers marked as Premium unlockable (freemium model or one-time unlock)
- Visualizer intensity slider

**Flutter Packages**
- flutter_audio_visualizer or custom FFT using fftea package
- Rive or Lottie for pre-built animations
- CustomPainter with Canvas API for real-time drawn visualizers
- OpenGL ES via flutter_gl for advanced 3D effects

### Feature 6 — Theme System and Music Stop Timer

**Description**  
The app supports Light and Dark mode with rich theming options, plus a sleep/stop timer so music automatically stops at a set time.

**Requirements — Theme**
- Light Mode and Dark Mode both fully implemented
- Dynamic color system — album art colors extracted and used as accent colors throughout the app (material you / monet style)
- Theme auto-switches based on device system setting or time of day
- Additional theme options: AMOLED Pure Black, Warm Sepia, Midnight Blue, Forest Green
- Font style selector (3 options minimum)
- Icon pack switcher

**Requirements — Stop Timer**
- Sleep timer accessible from Now Playing screen in one tap
- Preset durations: 5 min, 10 min, 15 min, 30 min, 45 min, 60 min, 90 min, End of Song, End of Playlist
- Custom time input
- Countdown visible on Now Playing screen
- Gentle fade-out before stop (last 10 seconds fade audio to silence)
- Option to also lock the screen when timer ends
- Timer persists across app background state

**Flutter Packages**
- flex_color_scheme or dynamic_color for theming
- palette_generator for extracting album art colors
- flutter_local_notifications for timer countdown

### Feature 7 — All Premium Music Features

**Description**  
Every feature expected from a top-tier paid music app, included by default.

**Requirements**
- Playlist creation, editing, reordering, cover art customization
- Smart auto-playlists: Most Played, Recently Added, Recently Played, Favorites
- Queue management with drag-to-reorder
- Song history with full playback log
- Speed control (0.5x to 2.0x playback speed without pitch distortion)
- Pitch control independent of speed
- A-B loop — mark two points in a song and loop that segment
- Bookmark moments in a song with a note
- Listen count and total listening time stats per song, artist, and genre
- Global stats dashboard (Spotify Wrapped style) available any time
- Shake to shuffle gesture
- Volume fade in on song start
- Last.fm scrobbling integration
- Discord Rich Presence integration (show what you are listening to)
- Bluetooth / car mode with simplified large button UI
- Android Auto and CarPlay support
- Widget support for home screen (small, medium, large)
- Share song with a 30-second clip export feature
- Song identification (Shazam-style listening and identifying unknown tracks)
- Radio mode — endless stream based on a seed song or artist

### Feature 8 — Music Image / Cover Art Management

**Description**  
Users can add, replace, or customize the cover art for any local song or album.

**Requirements**
- Auto-fetch cover art from MusicBrainz, Last.fm, or iTunes API based on song metadata
- If cover art missing, generate an AI-styled placeholder using song title initials with gradient
- User can manually set cover art by picking from gallery, camera, or web URL
- Bulk cover art fixer — scans library and flags songs with missing art, then fetches suggestions
- Album art shown in full blurred background in Now Playing screen
- Art saved in app cache and embedded back into the MP3/FLAC file ID3 tag optionally
- Animated cover art support (GIF or video loop as album art for online tracks where available)

**Flutter Packages**
- image_picker for manual cover art selection
- http for fetching from APIs
- flutter_image_compress for resizing before embedding
- id3_codec or audiotagger for writing back to audio file metadata

### Feature 9 — Multi-Device Music Sync (Group Listening)

**Description**  
Multiple users on different devices can play the same song in perfect sync, like a shared listening room.

**Requirements**
- Create a Sync Room with a unique room code (6-digit alphanumeric)
- Share room code or invite via link / QR code
- Host selects the song and controls playback for the room
- All guests receive play, pause, seek events and sync within 500ms
- Up to 50 devices in one room
- Guest mode — listeners can see queue and react with emoji but cannot control playback unless host grants DJ access
- DJ mode — host can grant control to specific guests
- In-room chat with text messages and emoji reactions
- Song voting / queue requests from guests
- Works over internet (not just LAN) using WebSocket or Firebase Realtime Database
- Sync algorithm corrects for network latency using timestamp offsets
- Room persists for 24 hours after creation
- Room history saved — user can rejoin old rooms

**Flutter Packages**
- web_socket_channel or Firebase Realtime Database for real-time sync
- qr_flutter and mobile_scanner for QR invite
- ntp package for network time protocol to calculate latency offsets accurately

### Feature 10 — Auto Music Categorization (AI-Powered)

**Description**  
The app automatically organizes the entire music library (offline and online) into smart categories based on mood, language, singer, energy level, and occasion.

**Requirements**
- Mood categories auto-assigned: Happy, Sad, Romantic, Energetic, Motivational, Chill, Angry, Focus, Sleep, Party
- Language detection and categorization: Hindi, English, Punjabi, Bhojpuri, Tamil, Telugu, Bengali, Marathi, Gujarati, and more
- Singer / Artist buckets auto-populated
- Decade and Era buckets: 90s, 2000s, 2010s, Recent
- Occasion playlists auto-generated: Workout, Study, Road Trip, Meditation, Morning Routine, Night Drive
- Beat per minute (BPM) classification: Slow, Medium, Fast
- For online songs — classification done using metadata and genre tags from the streaming API
- For offline songs — classification done using audio analysis (BPM, energy level) + ID3 tags
- User can override the auto-category for any song
- Smart Mixes auto-updated daily (like Spotify Daily Mix)
- "How I'm Feeling" shortcut on home screen — user picks an emoji and gets an instant auto-playlist

**Flutter Packages**
- tflite_flutter or on-device ML for mood/BPM classification
- Essentia audio analysis library via platform channel (C++ binding)
- Hive or Isar for fast local categorized indexing

### Feature 11 — Audio and Instrument Separation with Karaoke

**Description**  
Any song — offline or online — can be split into separate stems: vocals, drums, bass, guitar, piano, and other instruments. The separated stems enable karaoke mode, instrument practice, and remixing.

**Requirements**
- Stem separation for every song into: Vocals, Drums, Bass, Guitar/Piano, Other
- Processing done on-device using a lightweight ML model (Demucs or Spleeter quantized) or via cloud API for better quality
- User can choose: On-Device (slower, private, no internet needed) or Cloud (faster, higher quality, requires internet)
- Karaoke Mode: Vocals stem muted, instrumental plays — lyrics displayed in sync
- Vocal Spotlight Mode: All instruments muted, only vocals play (useful for learning lyrics)
- Instrument Practice Mode: Mute any individual stem to practice playing along
- Mixer UI: Individual volume sliders for each stem (like a real mixing board)
- Export separated stems as individual audio files
- Karaoke recording: User can sing along and record their voice over the instrumental, then play it back or share it
- Processing time indicator shown to user with estimated wait
- Previously separated songs cached so user does not wait again
- Works on both offline and online songs (online songs fetched first, then processed)

**Flutter Packages**
- tflite_flutter for on-device Demucs inference
- dio for cloud stem separation API calls
- just_audio with multiple audio sources mixed simultaneously for multi-stem playback
- Custom mixer UI with flutter Sliders and audio_session

## 4. Architecture Overview

**Frontend:** Flutter (Dart) — single codebase for Android, iOS, and Desktop

**State Management:** Riverpod or Bloc for reactive audio state, queue state, and sync state

**Local Database:** Isar or Hive for fast indexed music library storage, Drift (SQLite) for relational data like playlists and history

**Audio Engine:** just_audio as primary player, platform channels to native AudioEffect APIs for EQ and visualizer FFT data

**Backend (required for online features):**
- Firebase Realtime Database or custom WebSocket server for multi-device sync
- Firebase Auth for user accounts
- Cloud Functions for stem separation processing queue
- Firestore for user preferences, room state, and lyrics cache

**ML Models:**
- Demucs (quantized, ONNX format) for stem separation
- Simple CNN for mood classification based on mel spectrogram
- BPM detection via autocorrelation algorithm on audio samples

**APIs:**
- Musixmatch API for lyrics
- LRCLib (free) as fallback for LRC synced lyrics
- MusicBrainz + Last.fm for metadata and cover art
- JioSaavn unofficial API or licensed streaming API for online songs
- Song identification via ACRCloud or AudD API

## 5. User Interface and Navigation

**Bottom Navigation (5 tabs):**
- Home (Smart mixes, Mood shortcuts, Recent)
- Search (Unified offline + online search with filters)
- Library (Songs, Albums, Artists, Playlists, Downloads)
- Sync Room (Group listening hub)
- Profile (Stats, Settings, Theme, EQ)

**Now Playing Screen:**
- Full screen with animated visualizer behind album art
- Swipe up for lyrics panel
- Swipe left/right to switch songs
- Persistent mini player at bottom of all other screens

**Navigation pattern:** Go Router for declarative routing, Bottom sheet modals for song options, Shared element transitions between library card and Now Playing screen

## 6. Permissions Required

- READ_EXTERNAL_STORAGE / READ_MEDIA_AUDIO — to scan local files
- WRITE_EXTERNAL_STORAGE — to download songs
- INTERNET — for streaming and sync
- FOREGROUND_SERVICE — for background playback
- RECORD_AUDIO — for song identification listening and karaoke recording
- POST_NOTIFICATIONS — for download and playback notifications
- BLUETOOTH_CONNECT — for Bluetooth audio device management

## 7. Performance Requirements

- App cold start under 2 seconds
- Library scan for 10,000 songs under 8 seconds with progress shown
- Audio playback start under 500ms for local files
- Audio playback start under 2 seconds for online streams on 4G
- Visualizer renders at minimum 60fps on mid-range devices (Snapdragon 695 class)
- Memory usage under 250MB in steady state playback
- Stem separation on-device for a 3-minute song under 90 seconds on mid-range device
- Battery optimization — background playback drains no more than 3% per hour

## 8. Monetization Model

**Free Tier:**
- Offline playback — unlimited
- Online streaming with ads between every 5 songs
- 3 visualizer themes
- Basic equalizer with presets only
- Lyrics without animation
- Stem separation limited to 3 songs per month

**Premium Tier (one-time purchase or monthly subscription):**
- Ad-free streaming
- All 10+ visualizer themes
- Full parametric EQ with custom presets
- Animated synced lyrics
- Unlimited stem separation
- Multi-device sync rooms (host)
- Higher download quality up to 320kbps and FLAC
- Karaoke recording and export

## 9. Phased Delivery Plan

**Phase 1 — Core Player (Month 1-2)**  
Offline playback, basic UI, queue management, local library scanning, cover art fetch, dark and light theme, basic EQ

**Phase 2 — Online and Downloads (Month 3)**  
Online streaming integration, download manager, unified search, sleep timer, lyrics basic display

**Phase 3 — Premium Features (Month 4-5)**  
Synced animated lyrics, visualizers, full EQ, karaoke mode, stem separation (cloud first), auto categorization

**Phase 4 — Social and Sync (Month 6)**  
Multi-device sync rooms, group chat, song sharing, Last.fm and Discord integration

**Phase 5 — ML and Polish (Month 7-8)**  
On-device stem separation, mood classification, song identification, stats dashboard, Android Auto, CarPlay

## 10. Risk and Mitigation

- **Licensing risk for online streaming** — Mitigation: Use only APIs that provide licensed content or user's own YouTube Music / Spotify account via official SDK
- **Stem separation quality** — Mitigation: Offer both cloud (high quality) and on-device (private) options with clear quality expectations set for user
- **Multi-device sync latency** — Mitigation: Use NTP-corrected timestamps and predictive buffering. Test heavily on real networks not just localhost
- **App size bloat from ML models** — Mitigation: Download ML models on first use rather than bundling in APK. Use ONNX quantized models under 50MB
- **Battery drain from always-on visualizer** — Mitigation: Detect when screen is off and pause visualizer rendering. Give user option to disable visualizer to save battery

This PRD is ready to hand to a development team to begin sprint planning.
