# README for Member 3: Story Management Pages

## Overview
As Member 3, I was responsible for pages related to adding and editing stories, including form validation and integration with Firestore for saving data.

## Files Implemented
- **addstorypage.dart**: Page for adding new stories with image picker and form validation.
- **editstorypage.dart**: Page for editing existing stories with form validation.
- **story_model.dart**: Data model for stories.
- Portions of **firestore_service.dart**: Functions for adding and updating stories (addStory, updateStory).
- Portions of **app_strings.dart**: Strings related to adding/editing stories (e.g., labels, errors, toasts).

## Key Features
- Form fields for story details (title, author, page count, descriptions, PDF URL).
- Image picker for adding multiple images (local paths, with option for Firebase Storage upload).
- Validation for required fields and URL format.
- Saving to Firestore with toast notifications.
- Navigation from Add to Edit after saving (for testing linkage).

## Testing
- Tested adding and editing with mock Story objects.
- Used temporary main.dart with TestHomePage for navigation to both pages.
- Added Firebase Storage upload support for images (optional, can use local paths).

## Branch
- Branch: `story-management-pages`

## Notes
- Image paths are local during testing; upload to Storage for production.
- Ready for integration with HomePage (Member 2) for adding from admin.