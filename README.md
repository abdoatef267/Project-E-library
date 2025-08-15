# README for Member 2: Home and Favorites Pages

## Overview
As Member 2, I was responsible for the core user interface of the app, including the home page for displaying stories and the favorites page for managing user favorites. This involves fetching data from Firestore and handling user interactions like searching and toggling favorites.

## Files Implemented
- **home_page.dart**: Main page showing all stories in a grid, with search functionality, admin checks, and navigation to other pages.
- **favorite_page.dart**: Page displaying user's favorite stories, with toggle functionality.
- **story_card.dart**: Reusable widget for displaying individual stories with favorite toggle.
- Portions of **firestore_service.dart**: Functions for getting stories, favorite stories, and toggling favorites.
- Portions of **app_strings.dart**: Strings related to home and favorites (e.g., titles, messages, tooltips).

## Key Features
- Grid view of stories using `StoryCard`.
- Search bar for filtering stories.
- Favorite toggle with Firestore updates and toast notifications.
- Admin-specific features like adding stories (disabled during development).
- StreamBuilder for real-time story updates from Firestore.

## Testing
- Tested story display, search, and favorite toggle with mock data.
- Disabled navigation to other pages (AddStory, Settings, Details) using print statements.
- Created temporary main.dart for independent testing.

## Branch
- Branch: `home-favorite-pages`

## Notes
- Navigation disabled temporarily to avoid dependencies; restore in final merge.
- Integrated with Firestore for data fetching.