import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/product.dart';
import '../widgets/app_button.dart';

// Bonus Screen (+3 marks): Product Details page showing picture, name, price, and description.
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String productName = context.tr(product.nameKey);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('details.title')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with smooth Hero transition from HomePage
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: Hero(
                    tag: product.id,
                    child: Image.asset(
                      product.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Category pill & Star Rating
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      context.tr('categories.${product.categoryKey}'),
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star_rounded,
                    color: colorScheme.tertiary,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toString(),
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 350.ms),
              const SizedBox(height: 14),

              // Product Name
              Text(
                productName,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.15),
              const SizedBox(height: 8),

              // Price & Warranty Status (Wrap prevents overflow on narrow screens)
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  Text(
                    '${product.price} ${context.tr('app.currency')}',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: 18,
                        color: colorScheme.secondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        context.tr('details.in_stock'),
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ).animate().fadeIn(delay: 160.ms),
              const SizedBox(height: 20),
              Divider(color: colorScheme.outlineVariant),
              const SizedBox(height: 16),

              // Description Heading & Body
              Text(
                context.tr('details.description_title'),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.tr(product.descriptionKey),
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 220.ms),
              const SizedBox(height: 32),

              // Reusable AppButton to add to cart (UI feedback with SnackBar)
              AppButton(
                text: context.tr('details.add_to_cart'),
                icon: Icons.shopping_bag_outlined,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'details.added_snack'.tr(
                          namedArgs: {'name': productName},
                        ),
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(delay: 280.ms).slideY(begin: 0.15),
            ],
          ),
        ),
      ),
    );
  }
}
