# Quick Setup Guide

## Prerequisites
- Flutter SDK (>=3.0.0) installed
- Dart SDK (>=3.0.0)

## Setup Steps

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate Hive adapters (REQUIRED):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
   
   This will generate `lib/models/character_model.g.dart` which is required for Hive to work.

3. **Run the app:**
   ```bash
   flutter run
   ```

## Troubleshooting

### If you see errors about CharacterAdapter:
- Make sure you've run the build_runner command above
- The generated file `lib/models/character_model.g.dart` should exist

### If you see import errors:
- Run `flutter pub get` again
- Make sure all dependencies in `pubspec.yaml` are correct

### If Hive initialization fails:
- The app will still work, but offline caching may not function properly
- Check that you have proper file system permissions

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                  # Data models
├── services/                # API services
├── controllers/             # GetX controllers
├── screens/                 # UI screens
├── widgets/                 # Reusable widgets
└── theme/                   # Theme configuration
```

## Features Implemented

✅ Character list with infinite scroll
✅ Favorites management with star icon
✅ Offline caching with Hive
✅ Dark/Light theme toggle
✅ Sorting favorites (name, status, species)
✅ Smooth animations for favorite toggling
✅ Pull-to-refresh
✅ Error handling
✅ Loading states

Enjoy exploring Rick and Morty characters! 🚀

