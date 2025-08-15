# README for Member 4: Details, PDF Viewer, Settings, and Profile

## Overview
As Member 4, I was responsible for story details, PDF viewing, settings, and profile editing, including integration with Firestore and Bloc for state management.

## Files Implemented
- **story_pdf_viewer.dart**: Page for viewing PDF with zoom and reload, integrated with turnable_page for interactive flipping (using page_turn as alternative).
- **story_details_page.dart**: Page displaying story details with edit/delete for admins and PDF view button.
- **settings_page.dart**: Settings page with profile edit, theme toggle, and logout.
- **edit_profile_page.dart**: Page for editing user profile with Bloc management.
- **edit_profile_bloc.dart**, **edit_profile_event.dart**, **edit_profile_state.dart**: Bloc for profile editing.
- Portions of **app_strings.dart**: Strings related to details, PDF, settings, and profile.

## Key Features
- Story details with image carousel, descriptions, and admin actions.
- PDF viewer with zoom, reload, and interactive page turning.
- Settings with theme toggle and profile edit.
- Profile editing with validation and Firestore updates.

## Testing
- Tested with mock Story objects and temporary main.dart with TestHomePage.
- Disabled navigation to EditStoryPage and LoginPage using print statements.
- Integrated turnable_page (or page_turn) for PDF viewing.

## Branch
- Branch: `details-pdf-settings-pages`

## Notes
- PDF viewing uses internal viewer instead of external launcher.
- Restore navigation in final merge.