import 'package:flutter/material.dart';

// Data class for a shop product (final fields + const constructor, no build()).
class Product {
  const Product({
    required this.id,
    required this.nameKey,
    required this.descriptionKey,
    required this.categoryKey,
    required this.price,
    required this.imagePath,
    required this.icon,
    required this.rating,
  });

  final String id;
  final String nameKey;
  final String descriptionKey;
  final String categoryKey;
  final int price;
  final String imagePath;
  final IconData icon;
  final double rating;
}

// Local product catalog for VoltStore.
const List<Product> voltProducts = [
  Product(
    id: 'headphones',
    nameKey: 'products.headphones_name',
    descriptionKey: 'products.headphones_desc',
    categoryKey: 'audio',
    price: 680,
    imagePath: 'assets/images/prod_headphones.png',
    icon: Icons.headphones,
    rating: 4.9,
  ),
  Product(
    id: 'smartwatch',
    nameKey: 'products.smartwatch_name',
    descriptionKey: 'products.smartwatch_desc',
    categoryKey: 'wearables',
    price: 1150,
    imagePath: 'assets/images/prod_smartwatch.png',
    icon: Icons.watch,
    rating: 4.8,
  ),
  Product(
    id: 'keyboard',
    nameKey: 'products.keyboard_name',
    descriptionKey: 'products.keyboard_desc',
    categoryKey: 'keyboards',
    price: 490,
    imagePath: 'assets/images/prod_keyboard.png',
    icon: Icons.keyboard,
    rating: 4.9,
  ),
  Product(
    id: 'drone',
    nameKey: 'products.drone_name',
    descriptionKey: 'products.drone_desc',
    categoryKey: 'drones',
    price: 2100,
    imagePath: 'assets/images/prod_drone.png',
    icon: Icons.flight,
    rating: 4.7,
  ),
  Product(
    id: 'speaker',
    nameKey: 'products.speaker_name',
    descriptionKey: 'products.speaker_desc',
    categoryKey: 'audio',
    price: 340,
    imagePath: 'assets/images/prod_speaker.png',
    icon: Icons.speaker,
    rating: 4.6,
  ),
  Product(
    id: 'camera',
    nameKey: 'products.camera_name',
    descriptionKey: 'products.camera_desc',
    categoryKey: 'cameras',
    price: 2850,
    imagePath: 'assets/images/prod_camera.png',
    icon: Icons.photo_camera,
    rating: 4.9,
  ),
];
