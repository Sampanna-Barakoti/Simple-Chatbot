# PIE-BOT Chatbot

A modern Flutter chatbot application with DialogFlow integration and beautiful UI.

## Features

- 🎨 **Modern UI Design**: Clean, responsive chat interface with Material 3 design
- 🤖 **DialogFlow Integration**: Powered by Google's DialogFlow for intelligent responses
- 💬 **Real-time Chat**: Smooth messaging experience with typing indicators
- 📱 **Cross-platform**: Works on Android, iOS, Web, and Desktop
- 🎯 **User-friendly**: Intuitive interface with avatar icons and message bubbles

## UI Improvements

- **Flexible Message Layout**: Messages adapt to content with proper spacing
- **Avatar Icons**: User and bot avatars for better visual distinction
- **Typing Indicator**: Shows when bot is processing responses
- **Auto-scroll**: Automatically scrolls to latest messages
- **Empty State**: Friendly welcome message when chat is empty
- **Modern Input**: Rounded input field with send button
- **Responsive Design**: Works well on different screen sizes

## Setup

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Configure DialogFlow** (Optional):
   - Place your `dialog_flow_auth.json` file in the `assets/` folder
   - The app works with fallback responses if DialogFlow is not configured

3. **Run the App**:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── home.dart              # Main chat screen
└── messages_screen.dart   # Message display widget
```

## Dependencies

- `dialog_flowtter: ^0.3.3` - DialogFlow integration
- `flutter` - Flutter SDK

## Getting Started with Flutter

If this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
