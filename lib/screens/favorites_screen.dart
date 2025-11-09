import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorites_controller.dart';
import '../widgets/character_card.dart';
import '../widgets/loading_indicator.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritesController controller = Get.find<FavoritesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort by Name (A–Z)',
            onPressed: () {
              controller.setSortBy('name');
            },
          ),
        ],
      ),
      body: Obx(() {
        final favorites = controller.favorites;

        if (favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_border,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorites yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the star icon to add favorites',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        // Сортировка по имени в алфавитном порядке (A–Z)
        final sortedFavorites = List.of(favorites)
          ..sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

        return ListView.builder(
          itemCount: sortedFavorites.length,
          itemBuilder: (context, index) {
            return CharacterCard(
              character: sortedFavorites[index],
            );
          },
        );
      }),
    );
  }
}
