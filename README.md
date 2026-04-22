# technical_task_build_apps

## Environment Requirements

- Flutter SDK `3.41.6` (stable) or any newer stable version compatible with `Dart >=3.8.0 <4.0.0`
- Dart SDK (comes with Flutter)
- Android: Android Studio + Android SDK + Java 11
- iOS (macOS only): Xcode + Command Line Tools

Check local setup:

```bash
flutter doctor
```

## How to Run the Project

1. Clone the repository and open the project folder:

```bash
git clone <repository-link>
cd TechTask
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app on an available device/emulator/simulator:

```bash
flutter run
```

4. (Optional) Choose a specific device:

```bash
flutter devices
flutter run -d <device-id>
```

### Code Generation

Generated files are already committed, so code generation is **not required** for a fresh run.

Run it only after changing Freezed/JSON models:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```


