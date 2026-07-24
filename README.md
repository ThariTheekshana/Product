Product Catalogue App

A simple Flutter product catalogue app built as a practical assessment.

Project Overview

The app fetches a live product list from a public API and lets the user:

Browse products in a two-column grid (image, name, price, category, favourite icon)
Open a product's details screen (larger image, full description, favourite button)
Search products by name (substring match, updates as you type)
Mark/unmark favourites, kept in sync between the list and details screens
Favourites persist after the app is closed and reopened
Switch between a light and dark theme (also persisted)
See proper loading, error (with retry), and empty states

Product data comes from the free Fake Store API rather than hard-coded mock data, to demonstrate real HTTP integration, JSON parsing, and error handling.

Setup Instructions

Prerequisites: Flutter SDK (3.22+) installed and on your PATH.

bash
# 1. Get dependencies
flutter pub get

# 2. Run on a connected device / emulator
flutter run

# 3. Build a release APK
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
Architecture

Folder structure (lightweight MVVM):

lib/
  models/        # Product - plain data class + fromJson
  services/      # ApiService - raw HTTP call to the Fake Store API
  repositories/  # ProductRepository - thin layer between provider and API service
  providers/     # ProductProvider (list/search/favourites state), ThemeProvider
  views/         # ProductListScreen, ProductDetailsScreen
  widgets/       # ProductCard, StatusView (shared loading/error/empty UI)
  routes/        # go_router configuration
  utils/         # AppTheme (light/dark ThemeData)

State management: provider package. ProductProvider is a ChangeNotifier acting as the ViewModel - it owns the product list, search query, favourite IDs, and a ViewState enum (loading / loaded / error) that the UI switches on. ThemeProvider is a separate, small ChangeNotifier so theme state doesn't clutter the product logic.

API integration: ApiService makes a single GET request to fakestoreapi.com/products, decodes the JSON, and maps it to Product objects. It throws a typed ApiException on network/parsing/server errors, which ProductProvider catches and turns into the error state (with a message and retry action) the UI can show.

Navigation: go_router, with the product object passed via extra to the details route so there's no need to re-fetch or look up a product by ID.

Favourites & theme persistence: shared_preferences. Favourite product IDs are stored as a string list; the theme choice as a bool. Both are loaded once on startup and written whenever they change.

Assumptions
The Fake Store API's public demo endpoint is stable enough to rely on for this assessment; no authentication is required.
"Favourites" only needs to persist locally on-device - no backend sync.
A 2-column grid is a reasonable layout for a phone-sized catalogue; no tablet-specific layout was implemented since it wasn't asked for.
Challenges
Balancing "don't over-architect" with still having a clean, testable separation of concerns - kept to four small layers (API service, repository, provider, UI) instead of adding use-case or domain layers that would be overkill for this scope.
Making sure favourite state stays in sync between the list and details screens without duplicating state - solved by having both screens read favourite status from the same ProductProvider rather than local widget state.
Hit a crash where favourites failed to load because of leftover invalid data in local storage (int.parse throwing on a non-numeric string). Fixed by using int.tryParse and filtering out anything invalid instead of assuming stored data is always well-formed.
Improvements
Add unit tests for ProductProvider (search filtering, favourite toggling) and ApiService (mocked HTTP responses).
Debounce the search field if the product list were much larger.
Add pull-to-refresh on the list screen.
Show a small "no internet" banner distinct from a generic server error.
