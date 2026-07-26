import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/product_provider.dart';
import '../utils/app_constants.dart';
import '../widgets/product_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.favouritesTitle, style: AppTextStyles.appBarTitle),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          final favourites = provider.favouriteProducts;
          if (favourites.isEmpty) {
            final theme = Theme.of(context);
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64.r,
                    color: theme.colorScheme.outline,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    AppStrings.noFavouritesTitle,
                    style: AppTextStyles.emptyTitle(theme),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppStrings.noFavouritesSubtitle,
                    style: AppTextStyles.emptySubtitle(theme),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.62,
            ),
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final product = favourites[index];
              return ProductCard(
                product: product,
                isFavourite: true,
                onTap: () => context.push('/details', extra: product),
                onFavouriteTap: () => provider.toggleFavourite(product.id),
              );
            },
          );
        },
      ),
    );
  }
}
