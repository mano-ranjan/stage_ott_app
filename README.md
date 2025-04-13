# OTT Stage App

A Flutter-based movie search application that allows users to search for movies and manage their favorites.

## Features

- Search movies using OMDB API
- View movie details including plot, year, and poster
- Save favorite movies for offline access
- Responsive grid layout
- Offline support with Hive local storage
- Network connectivity handling
- Smooth animations and transitions

## Tech Stack

- Flutter
- Provider for state management
- Hive for local storage
- Cached Network Image for image caching
- Connectivity Plus for network status

## Getting Started

### Prerequisites

- Flutter SDK (Latest stable version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/mano-ranjan/stage_ott_app.git
```

2. Navigate to project directory:
```bash
cd stage_ott_app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

### Configuration

The app uses the OMDB API. You'll need to:
1. Get an API key from [OMDB API](http://www.omdbapi.com/)
2. Add your API key in `lib/utils/constants.dart`

## Project Structure

```
lib/
├── models/          # Data models
├── providers/       # State management
├── screens/         # UI screens
├── services/        # API services
├── utils/          # Utilities and constants
└── widgets/        # Reusable widgets
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  cached_network_image: ^3.4.1
  connectivity_plus: ^5.0.2
```

## Features to Add

- Movie details page enhancement
- Search history
- Category-based browsing
- User ratings and reviews
- Dark/Light theme toggle

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
