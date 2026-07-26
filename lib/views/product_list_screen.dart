// views/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/product_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_constants.dart';
import '../widgets/product_card.dart';
import '../widgets/status_view.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppStrings.storeTitle, style: AppTextStyles.appBarTitle),
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) => IconButton(
              tooltip: AppStrings.toggleThemeTooltip,
              icon: Icon(
                themeProvider.isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
              onPressed: themeProvider.toggleTheme,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                child: TextField(
                  onChanged: context.read<ProductProvider>().search,
                  decoration: const InputDecoration(
                    hintText: AppStrings.searchHint,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<ProductProvider>(
                  builder: (context, provider, _) {
                    switch (provider.state) {
                      case ViewState.loading:
                        return const Center(child: CircularProgressIndicator());
                      case ViewState.error:
                        return StatusView(
                          icon: Icons.wifi_off_rounded,
                          message: provider.errorMessage,
                          actionLabel: AppStrings.retry,
                          onAction: provider.loadProducts,
                        );
                      case ViewState.loaded:
                        final products = provider.products;
                        if (products.isEmpty) {
                          return StatusView(
                            icon: provider.searchQuery.isEmpty
                                ? Icons.inventory_2_outlined
                                : Icons.search_off_rounded,
                            message: provider.searchQuery.isEmpty
                                ? AppStrings.noProducts
                                : AppStrings.noSearchResults(
                                    provider.searchQuery),
                          );
                        }
                        return GridView.builder(
                          padding:
                              EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 90.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 0.62,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              product: product,
                              isFavourite: provider.isFavourite(product.id),
                              onTap: () =>
                                  context.push('/details', extra: product),
                              onFavouriteTap: () =>
                                  provider.toggleFavourite(product.id),
                            );
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          ),
          Consumer<ProductProvider>(
            builder: (context, provider, _) {
              final count = provider.favouriteProducts.length;
              if (count == 0) return const SizedBox.shrink();
              return Positioned(
                bottom: 24.h,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () => context.push('/favourites'),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 28.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite,
                              color: Colors.white, size: 18.r),
                          SizedBox(width: 10.w),
                          Text(
                            AppStrings.viewFavourites(count),
                            style: AppTextStyles.capsuleButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
