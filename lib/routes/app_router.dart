import 'package:go_router/go_router.dart';
import '../models/product.dart';
import '../views/product_list_screen.dart';
import '../views/product_details_screen.dart';
import '../views/favourites_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final product = state.extra as Product;
        return ProductDetailsScreen(product: product);
      },
    ),
    GoRoute(
      path: '/favourites',
      builder: (context, state) => const FavouritesScreen(),
    ),
  ],
);
