import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStrings {
  AppStrings._();

  // AppBar titles
  static const String storeTitle = 'Store';
  static const String productDetailsTitle = 'Details';
  static const String favouritesTitle = 'Favourites';

  // Search
  static const String searchHint = 'Search products...';

  // Tooltips
  static const String toggleThemeTooltip = 'Toggle theme';

  // Status messages
  static const String noProducts = 'No products available right now.';
  static const String retry = 'Retry';

  // Favourites
  static const String noFavouritesTitle = 'No favourites yet';
  static const String noFavouritesSubtitle =
      'Tap the heart icon on any product to save it here.';

  // Product details
  static const String descriptionLabel = 'Description';

  // Dynamic builders
  static String viewFavourites(int count) => 'View Favourites · $count';
  static String noSearchResults(String query) => 'No products match "$query".';
  static String priceLabel(double price) => '\$${price.toStringAsFixed(2)}';
}

class AppTextStyles {
  AppTextStyles._();

  // AppBar title — 24sp bold, used on all screens
  static TextStyle get appBarTitle => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  // Capsule / floating favourites button
  static TextStyle get capsuleButton => TextStyle(
        color: Colors.white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  // ── Product card ──────────────────────────────────────────
  static TextStyle? cardTitle(ThemeData t) =>
      t.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      );

  static TextStyle? cardCategory(ThemeData t) =>
      t.textTheme.bodySmall?.copyWith(
        color: t.colorScheme.outline,
        fontSize: 12.sp,
      );

  static TextStyle? cardPrice(ThemeData t) =>
      t.textTheme.titleMedium?.copyWith(
        color: t.colorScheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
      );

  // ── Product details screen ────────────────────────────────
  static TextStyle? detailsCategory(ThemeData t) =>
      t.textTheme.labelMedium?.copyWith(
        color: t.colorScheme.primary,
        fontSize: 13.sp,
        letterSpacing: 0.5,
      );

  static TextStyle? detailsTitle(ThemeData t) =>
      t.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 26.sp,
      );

  static TextStyle? detailsPrice(ThemeData t) =>
      t.textTheme.titleLarge?.copyWith(
        color: t.colorScheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 24.sp,
      );

  static TextStyle? detailsSectionLabel(ThemeData t) =>
      t.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
      );

  static TextStyle? detailsBody(ThemeData t) =>
      t.textTheme.bodyMedium?.copyWith(
        fontSize: 15.sp,
        height: 1.6,
      );

  // ── Favourites empty state ────────────────────────────────
  static TextStyle? emptyTitle(ThemeData t) =>
      t.textTheme.titleMedium?.copyWith(
        color: t.colorScheme.outline,
        fontSize: 16.sp,
      );

  static TextStyle? emptySubtitle(ThemeData t) =>
      t.textTheme.bodySmall?.copyWith(
        color: t.colorScheme.outline,
        fontSize: 13.sp,
      );
}
