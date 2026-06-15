# Note App Hive

A clean Flutter practice project that demonstrates how to build a simple offline notes app with the Hive local database.

The app stores notes directly on the device, listens to box updates in real time, and supports the full basic CRUD flow:

- Create a note
- Read notes from local storage
- Update an existing note
- Delete a note

## Overview

This project is focused on learning and practicing local persistence in Flutter using Hive. It uses a lightweight `NotesModel`, a dedicated box helper, and a simple single-screen UI to show how local data can be saved and rendered without a remote backend.

## Features

- Offline note storage with Hive
- Real-time UI updates using `ValueListenableBuilder`
- Add note dialog
- Edit note dialog
- Delete note action
- Generated Hive adapter for typed model storage
- Multi-platform Flutter project structure

## Tech Stack

- Flutter
- Dart SDK `^3.11.5`
- Hive
- hive_flutter
- path_provider
- build_runner
- hive_generator

## Project Structure

```text
lib/
  main.dart                 App bootstrap and Hive initialization
  boxes/
    boxes.dart              Shared helper for opening the notes box
  models/
    notes_model.dart        Hive model definition
    notes_model.g.dart      Generated Hive type adapter
  screens/
    home_screen.dart        Notes list and CRUD dialogs
```

## How It Works

### 1. Hive Initialization

The app initializes Hive in `main.dart`, points it to the application documents directory, registers the `NotesModelAdapter`, and opens the `notes` box before rendering the UI.

### 2. Data Model

`NotesModel` is a Hive object with two persisted fields:

- `title`
- `description`

### 3. Box Access

`Boxes.getData()` centralizes access to the `notes` box:

```dart
static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
```

### 4. UI Updates

The home screen listens to Hive box changes through `ValueListenableBuilder`, so the notes list refreshes automatically whenever data is added, edited, or removed.

## Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK installed
- A configured emulator, simulator, or desktop target

### Installation

1. Clone the repository:

```bash
git clone <your-repository-url>
cd hive-flutter-practice
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## Code Generation

This project uses Hive code generation for the model adapter. If you change the fields inside `NotesModel`, regenerate the adapter with:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Learning Goals Covered

- Setting up Hive in a Flutter project
- Creating a Hive model with annotations
- Registering a generated adapter
- Opening and using a typed Hive box
- Building a local CRUD interface
- Reflecting local database changes in the UI

## Current Scope

This project is intentionally small and focused on local database practice. It currently uses a single screen and local-only storage without authentication, syncing, or cloud backup.

## Possible Improvements

- Add form validation for empty notes
- Add note timestamps
- Add search and filtering
- Add categories or tags
- Improve dialog and button styling
- Add widget and persistence tests

## License

This project is for learning and practice. Add a license here if you plan to publish or distribute it.
