# Turbo Shark: A Multithreaded Download Manager

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

Turbo Shark is a Flutter-based multithreaded download manager designed to efficiently download files by breaking them into segments and downloading them concurrently. This approach significantly speeds up the download process, especially for large files.

## Features

-   **Multithreaded Downloading:** Utilizes Dart isolates to download file segments concurrently, improving download speed.
-   **Progress Tracking:** Provides real-time progress updates for each download.
-   **Download States:** Tracks the state of each download (e.g., in progress, done, failed).
-   **Customizable Segment Count:** Allows you to specify the number of segments to use for downloading.
-   **User-Friendly UI:** Simple and intuitive user interface using custom drawer for navigation.
-   **Theme Support:**  Supports dark and light themes.

## Project Structure

The project is organized as follows:

```
turbo_shark/
├── lib/
│   ├── enums/
│   │   └── downloadState.dart
│   ├── ssl/
│   │    └── ssl_handler.dart
│   ├── models/
│   │    └── themeState.dart
│   ├── screens/
│   │   ├── downloadsScreen.dart
│   │   ├── historyScreens.dart
│   │   └── settingsScreen.dart
│   ├── main.dart       // Entry point of the app
│   └── concurrent_file_downloader.dart  // Core download logic
├── assets/
│   └── logo.png
├── pubspec.yaml
└── README.md
```



## Core Logic

The core download functionality is encapsulated within the `ConcurrentFileDownloader` class. This class is responsible for:

1.  **Segmenting Files:** Dividing large files into smaller segments for concurrent download.
2.  **Concurrent Downloads:** Utilizing Dart isolates to download these segments simultaneously, improving speed.
3.  **Progress Updates:** Sending real-time progress information back to the main thread to update the UI.
4.  **State Management:** Tracking the state of each download (in progress, complete, failed) and updating the user interface accordingly.

## Dependencies

The following pub.dev packages are used in this project:

-   `provider`: For state management.
-   `google_fonts`: For custom fonts in the UI.

You can add these dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  google_fonts: ^6.1.0
```

## Usage

1.  **Clone the repository:**
    ```bash
    git clone [your-repository-url]
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd turbo_shark
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

## Known Issues/Limitations

-   **Error Handling:** The current error handling is basic. More robust error handling and retry mechanisms can be implemented.
-   **Resuming Downloads:** The current implementation doesn't support resuming interrupted downloads.
-   **UI Polishing:** The UI could be improved with better feedback on loading states and error conditions.
-   **Platform Specifics:** Further platform-specific optimizations might be needed for optimal performance.
-   **Testing:** Further testing would help to find bugs.

## Contributing

Contributions are always welcome! If you have any ideas for improvements or find any bugs, feel free to submit a pull request.


