# Flutter Team Project: Story App

## Overview
This is a collaborative Flutter project for a story management app, built by a team of 4 members. The app allows users to browse, add, edit, and favorite stories, with authentication, profile management, and PDF viewing. It uses Firebase for backend services (Auth, Firestore, Storage) and Bloc for state management.

## Features
- User authentication (login, registration, logout).
- Home page with story grid, search, and favorites.
- Adding and editing stories with images and PDF.
- Story details with delete/edit for admins.
- Favorites page for managing liked stories.
- PDF viewer with interactive page turning.
- Settings with profile editing and theme toggle.

## Tech Stack
- Flutter for UI.
- Firebase: Auth, Firestore, Storage.
- Bloc for state management.
- Image Picker for adding images.
- Syncfusion PDF Viewer + turnable_page (or page_turn) for PDF display.
- Toast for notifications.

## Team Contributions
- **Member 1**: Authentication (login/register), Auth Bloc/Service.
- **Member 2**: Home/Favorites pages, Story Card.
- **Member 3**: Add/Edit Story pages, Story Model.
- **Member 4**: Story Details/PDF Viewer, Settings/Profile Edit.

## Setup
1. Clone the repo: `git clone <repo-url>`.
2. Install dependencies: `flutter pub get`.
3. Setup Firebase: Add `firebase_options.dart` and configure console.
4. Run: `flutter run`.

## Branches
- Main: Integrated code.
- Member branches: auth-pages, home-favorite-pages, story-management-pages, details-pdf-settings-pages.

## Testing
- Each member tested independently with temporary main.dart.
- Full integration tested after merging.

## Future Improvements
- Full image upload to Storage.
- Advanced search filters.