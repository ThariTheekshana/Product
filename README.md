# Product Catalogue App

A Flutter app that fetches products from a public API and lets users browse, search, and save favourites.

---

## Features

- Browse products in a 2-column grid (image, name, price, category)
- View full product details
- Search products by name in real time
- Mark / unmark favourites (synced across screens, saved locally)
- Light and dark theme toggle (saved locally)
- Loading, error with retry, and empty states

---

## Setup

Requires Flutter SDK 3.22+

```bash
flutter pub get
flutter run
```

---

## Project Structure

```
lib/
├── main.dart
├── models/         # Product data class + fromJson
├── services/       # HTTP call to Fake Store API
├── repositories/   # Thin layer between provider and service
├── providers/      # ProductProvider (state), ThemeProvider
├── views/          # ProductListScreen, ProductDetailsScreen, FavouritesScreen
├── widgets/        # ProductCard, StatusView (loading/error/empty)
├── routes/         # go_router setup
├── utils/          # AppTheme, AppConstants (strings, text styles)
└── errors/         # Typed exceptions (Network, Server, Parse, Unexpected)
```

---

## Architecture

Lightweight MVVM — four layers: `ApiService` → `ProductRepository` → `ProductProvider` → UI.

- **State management** — `provider` package. `ProductProvider` owns the product list, search query, favourites, and a `ViewState` enum the UI switches on.
- **Navigation** — `go_router`. Product object is passed via `extra` to the details route.
- **Persistence** — `shared_preferences` for favourite IDs and theme choice.
- **Error handling** — `ApiService` throws typed `AppException` subclasses; `ProductProvider` catches them and exposes an error state with a retry action.

---

## Packages

| Package | Purpose |
|---|---|
| `provider` | State management |
| `go_router` | Navigation |
| `http` | API requests |
| `shared_preferences` | Local persistence |
| `cached_network_image` | Image loading & caching |
| `flutter_screenutil` | Responsive sizing |
| `google_fonts` | Poppins font |

---

## Demo

**Screen Recording**

https://github.com/ThariTheekshana/Product/raw/main/Screen%20Record/ScreenRecord.mp4

---

## Screenshots

**Product List Screen**

![Product List](Screenshots/Product%20List%20Screen.png)

**Dark Theme Product List**

![Dark Theme](Screenshots/Dark%20Theme%20Product%20List.png)

**Search Product**

![Search](Screenshots/Search%20Product.png)

**Product Details**

![Product Details](Screenshots/Product%20Details.png)

**Favourite Screen**

![Favourites](Screenshots/Favourite%20Screen.png)

**Added Favourite**

![Added Favourite](Screenshots/Added%20Favourite.png)

[![Download APK](https://img.shields.io/badge/Download-APK-green?style=for-the-badge&logo=android)](https://github.com/ThariTheekshana/Product/raw/main/apk/app-release.apk)