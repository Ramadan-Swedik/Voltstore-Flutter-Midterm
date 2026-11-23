import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/product.dart';
import '../widgets/category_tile.dart';
import '../widgets/product_card.dart';
import 'product_details_page.dart';
import 'settings_page.dart';

// Screen 5: Shop Home Page with Categories (GridView.count) and Products (GridView.builder) (Lecture 12).
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.userName,
    required this.onThemeChanged,
  });

  final String userName;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Active category filter updated with setState when the user taps a CategoryTile.
  String _selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final String displayUser = widget.userName.isEmpty
        ? context.tr('home.guest')
        : widget.userName;

    final List<Product> visibleProducts = _selectedCategory == 'all'
        ? voltProducts
        : voltProducts
            .where((product) => product.categoryKey == _selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo.png',
                width: 28,
                height: 28,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              context.tr('home.title'),
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: context.tr('home.settings_tooltip'),
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    userName: widget.userName,
                    onThemeChanged: widget.onThemeChanged,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Greeting Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: [
                    colorScheme.primary,
                    colorScheme.secondary,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr(
                      'home.greeting',
                      namedArgs: {'user': displayUser},
                    ),
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.tr('home.banner_title'),
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.tr('home.banner_subtitle'),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimary.withValues(alpha: 0.88),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.12),
            const SizedBox(height: 22),

            // Section 1: Categories (GridView.count — fixed 6 tiles, Lecture 12)
            Text(
              context.tr('home.categories_title'),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.45,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CategoryTile(
                  icon: Icons.grid_view_rounded,
                  label: context.tr('categories.all'),
                  isSelected: _selectedCategory == 'all',
                  onTap: () => setState(() => _selectedCategory = 'all'),
                ),
                CategoryTile(
                  icon: Icons.headphones_rounded,
                  label: context.tr('categories.audio'),
                  isSelected: _selectedCategory == 'audio',
                  onTap: () => setState(() => _selectedCategory = 'audio'),
                ),
                CategoryTile(
                  icon: Icons.watch_rounded,
                  label: context.tr('categories.wearables'),
                  isSelected: _selectedCategory == 'wearables',
                  onTap: () => setState(() => _selectedCategory = 'wearables'),
                ),
                CategoryTile(
                  icon: Icons.keyboard_rounded,
                  label: context.tr('categories.keyboards'),
                  isSelected: _selectedCategory == 'keyboards',
                  onTap: () => setState(() => _selectedCategory = 'keyboards'),
                ),
                CategoryTile(
                  icon: Icons.flight_rounded,
                  label: context.tr('categories.drones'),
                  isSelected: _selectedCategory == 'drones',
                  onTap: () => setState(() => _selectedCategory = 'drones'),
                ),
                CategoryTile(
                  icon: Icons.photo_camera_rounded,
                  label: context.tr('categories.cameras'),
                  isSelected: _selectedCategory == 'cameras',
                  onTap: () => setState(() => _selectedCategory = 'cameras'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section 2: Products Grid (GridView.builder — built from data, Lecture 12)
            Text(
              context.tr('home.products_title'),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.74,
              ),
              itemCount: visibleProducts.length,
              itemBuilder: (context, index) {
                final Product product = visibleProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    // Bonus (+3 marks): open the Product Details page with the tapped product.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: product),
                      ),
                    );
                  },
                )
                    .animate(delay: (60 * index).ms)
                    .fadeIn(duration: 350.ms)
                    .slideY(begin: 0.12);
              },
            ),
          ],
        ),
      ),
    );
  }
}
