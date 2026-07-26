import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product.dart';
import '../utils/app_constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavourite;
  final VoidCallback onTap;
  final VoidCallback onFavouriteTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavourite,
    required this.onTap,
    required this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      padding: EdgeInsets.all(12.r),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image_outlined,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Material(
                      color: theme.colorScheme.surface.withValues(alpha: 0.85),
                      shape: const CircleBorder(),
                      child: IconButton(
                        iconSize: 20.r,
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: isFavourite
                              ? Colors.redAccent
                              : theme.colorScheme.onSurface,
                        ),
                        onPressed: onFavouriteTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 4.h),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardTitle(theme),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 2.h),
              child: Text(
                product.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardCategory(theme),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
              child: Text(
                AppStrings.priceLabel(product.price),
                style: AppTextStyles.cardPrice(theme),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
