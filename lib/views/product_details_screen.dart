// views/product_details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../utils/app_constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.productDetailsTitle,
          style: AppTextStyles.appBarTitle,
        ),
        actions: [
          Consumer<ProductProvider>(
            builder: (context, provider, _) {
              final isFav = provider.isFavourite(product.id);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.redAccent : null,
                ),
                onPressed: () => provider.toggleFavourite(product.id),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 240.h,
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.broken_image_outlined,
                    size: 48.r,
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              product.category.toUpperCase(),
              style: AppTextStyles.detailsCategory(theme),
            ),
            SizedBox(height: 6.h),
            Text(
              product.title,
              style: AppTextStyles.detailsTitle(theme),
            ),
            SizedBox(height: 10.h),
            Text(
              AppStrings.priceLabel(product.price),
              style: AppTextStyles.detailsPrice(theme),
            ),
            SizedBox(height: 20.h),
            Text(
              AppStrings.descriptionLabel,
              style: AppTextStyles.detailsSectionLabel(theme),
            ),
            SizedBox(height: 8.h),
            Text(
              product.description,
              style: AppTextStyles.detailsBody(theme),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
