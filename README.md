# Rick and Morty Character Explorer

A Flutter mobile application that allows users to browse Rick and Morty characters, mark favorites, and access data offline.

## 📱 Features

- **Character List**: Browse all Rick and Morty characters with infinite scroll pagination
- **Favorites**: Mark and manage favorite characters with a star icon
- **Offline Support**: Access previously loaded characters and favorites without internet
- **Dark/Light Theme**: Toggle between dark and light themes
- **Sorting**: Sort favorites by name, status, or species
- **Smooth Animations**: Animated transitions when adding/removing favorites
- **Caching**: Local caching of character data for offline access

## 🛠️ Tech Stack

- **Flutter**: SDK >=3.0.0
- **GetX**: State management and routing
- **Dio**: HTTP client for API requests
- **Hive**: Fast, lightweight local database for caching and favorites
- **Cached Network Image**: Efficient image loading and caching

## 📋 Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions
- Android SDK / Xcode (for mobile development)

## 🚀 Installation

1. **Clone the repository** (or navigate to the project directory)

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (required for the Character model):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── character_model.dart    # Character data model with Hive adapter
├── services/
│   └── api_service.dart        # API service for fetching characters
├── controllers/
│   ├── character_controller.dart    # GetX controller for character list
│   └── favorites_controller.dart    # GetX controller for favorites
├── screens/
│   ├── home_screen.dart        # Main screen with bottom navigation
│   ├── characters_screen.dart  # All characters list screen
│   ├── favorites_screen.dart   # Favorites list screen
│   └── splash_screen.dart      # Splash screen (optional)
├── widgets/
│   ├── character_card.dart    # Reusable character card widget
│   └── loading_indicator.dart # Loading indicator widget
└── theme/
    └── app_theme.dart          # Theme configuration (light/dark)
```

## 🔧 Dependencies

### Main Dependencies
- `dio: ^5.4.0` - HTTP client
- `get: ^4.6.6` - State management and routing
- `hive: ^2.2.3` - Local database
- `hive_flutter: ^1.1.0` - Hive Flutter integration
- `path_provider: ^2.1.1` - File system paths
- `cached_network_image: ^3.3.0` - Image caching

### Dev Dependencies
- `hive_generator: ^2.0.1` - Code generation for Hive
- `build_runner: ^2.4.7` - Code generation runner

## 🌐 API

The app uses the [Rick and Morty API](https://rickandmortyapi.com/documentation/):
- Base URL: `https://rickandmortyapi.com/api`
- Endpoint: `/character`
- Documentation: https://rickandmortyapi.com/documentation/

## 📱 Usage

### Main Screen
- **All Characters Tab**: Browse all characters with infinite scroll
- Pull down to refresh the character list
- Tap the star icon to add/remove favorites
- Tap the theme icon to toggle dark/light mode

### Favorites Screen
- View all favorited characters
- Use the sort menu to sort by name, status, or species
- Remove favorites by tapping the star icon

### Offline Mode
- Previously loaded characters are cached and available offline
- Favorites are stored locally and persist across app restarts
- New data is fetched when online

## 🎨 Theme

The app supports both light and dark themes:
- Toggle via the theme icon in the app bar
- Theme preference persists across app restarts
- Custom color scheme with Rick and Morty inspired colors

## 🏗️ Architecture

The app follows **Clean Architecture** principles:
- **Models**: Data models with Hive adapters
- **Services**: API and business logic
- **Controllers**: GetX controllers for state management
- **Screens**: UI screens
- **Widgets**: Reusable UI components

## 🔄 State Management

- **GetX** is used for:
  - Reactive state management (RxList, RxBool, etc.)
  - Dependency injection
  - Navigation (though bottom navigation uses IndexedStack)

## 💾 Data Persistence

- **Hive** is used for:
  - Caching character data (JSON format)
  - Storing favorite character IDs
  - Storing individual character objects for quick access

## 🐛 Troubleshooting

### Hive Adapter Generation
If you encounter errors related to Hive adapters:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Build Issues
If you encounter build issues:
```bash
flutter clean
flutter pub get
flutter run
```

## 📝 Notes

- The app caches character data locally for offline access
- Favorites are stored separately and persist across app restarts
- Infinite scroll loads more characters as you scroll down
- Images are cached automatically using `cached_network_image`

