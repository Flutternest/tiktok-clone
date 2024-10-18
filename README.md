# TikTok Clone

This repository contains the source code for a TikTok-like application built using Flutter. This app allows users to create, share, and view short videos, similar to the popular TikTok platform.

**Video demo:**

https://github.com/Flutternest/tiktok-clone/raw/refs/heads/main/demos/vid_demo.mp4

## Screenshots

| Screenshot 1 | Screenshot 2 |
|--------------|--------------|
| ![Screenshot 1](https://github.com/Flutternest/tiktok-clone/blob/main/demos/4.jpg?raw=true) | ![Screenshot 2](https://github.com/Flutternest/tiktok-clone/blob/main/demos/1.jpg?raw=true) |
| Screenshot 3 | Screenshot 4 |
| ![Screenshot 3](https://github.com/Flutternest/tiktok-clone/blob/main/demos/3.jpg?raw=true) | ![Screenshot 4](https://github.com/Flutternest/tiktok-clone/blob/main/demos/2.jpg?raw=true) |

## Table of Contents
- [Features](#features)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [Screenshots](#screenshots)
- [License](#license)

## Features
- **Video Feed**: Scroll through a feed of short videos.
- **Video Upload**: Record and upload your own videos.
- **User Authentication**: Sign in with Google or Apple.
- **Comments and Likes**: Interact with videos by liking and commenting.
- **Profile Management**: Manage your profile and view your uploaded videos.
- **Firebase Integration**: Authentication, Firestore, and Storage.

## Architecture
The application follows a modular architecture with a focus on separation of concerns. Here are the main components:

### Model
- **Data Models**: Represent the data structure of the application (e.g., `Feed`, `UserData`).
- **Repositories**: Handle data fetching and caching (e.g., `FirebaseTikTokVideosRepository`).

### View
- **UI Components**: Built with Flutter's `Material` and `Cupertino` widgets.
- **Screens and Widgets**: Display data and handle user interactions (e.g., `HomePage`, `ProfilePage`, `CreatingPostPage`).

### Controller
- **State Management**: Using `flutter_riverpod` for state management.
- **Controllers**: Manage the logic and state of the application (e.g., `AuthController`, `FeedProvider`).

### Additional Components
- **Networking**: Handled by `http` for HTTP requests.
- **JSON Serialization**: Using `json_serializable` for JSON parsing.
- **Video Playback**: Integrated with `video_player` and `chewie`.
- **Firebase Services**: Authentication, Firestore, and Storage.

## Installation
To get started with the project, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/Flutternest/tiktok-clone.git && cd tiktok-clone
    ```

2. Install the dependencies:
    ```bash
    flutter pub get
    ```

3. Set up the Firebase configuration:
    - Add your `google-services.json` file to the `android/app` directory.
    - Add your `GoogleService-Info.plist` file to the `ios/Runner` directory.

4. Run the project:
    ```bash
    flutter run
    ```

## Usage
To use the TikTok Clone app, simply run the project on an Android or iOS device or emulator. The app will display a feed of videos, allowing you to browse, upload, and interact with content.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate (if any).