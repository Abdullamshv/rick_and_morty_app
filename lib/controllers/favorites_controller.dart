import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/character_model.dart';

class FavoritesController extends GetxController {
  static const String _favoritesBoxName = 'favorites';
  late Box<int> _favoritesBox;

  final RxList<Character> favorites = <Character>[].obs;
  final RxString sortBy = 'name'.obs; // 'name', 'status', 'species'
  final RxSet<int> favoriteIds = <int>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    await _initHive();
    loadFavorites();
  }

  Future<void> _initHive() async {
    _favoritesBox = await Hive.openBox<int>(_favoritesBoxName);
    _loadFavoriteIds();
  }

  void _loadFavoriteIds() {
    favoriteIds.assignAll(_favoritesBox.keys.cast<int>());
  }

  bool isFavorite(int characterId) {
    return favoriteIds.contains(characterId);
  }

  Future<void> toggleFavorite(Character character) async {
    if (isFavorite(character.id)) {
      await removeFavorite(character.id);
    } else {
      await addFavorite(character);
    }
    // Refresh favorites list if we're on favorites screen
    loadFavorites();
  }

  Future<void> addFavorite(Character character) async {
    await _favoritesBox.put(character.id, character.id);
    favoriteIds.add(character.id);
    
    // Store character in characters box for persistence
    try {
      final characterBox = Hive.box<Character>('characters');
      await characterBox.put(character.id, character);
    } catch (e) {
      print('Error storing character: $e');
    }
    
    if (!favorites.any((c) => c.id == character.id)) {
      favorites.add(character);
      _sortFavorites();
    }
  }

  Future<void> removeFavorite(int characterId) async {
    await _favoritesBox.delete(characterId);
    favoriteIds.remove(characterId);
    favorites.removeWhere((c) => c.id == characterId);
  }

  void loadFavorites() {
    _loadFavoriteIds();
    try {
      final characterBox = Hive.box<Character>('characters');
      favorites.value = _favoritesBox.keys
          .map((id) => characterBox.get(id))
          .whereType<Character>()
          .toList();

      // If not found in character box, try to load from cache
      if (favorites.isEmpty) {
        _loadFavoritesFromCache();
      } else {
        _sortFavorites();
      }
    } catch (e) {
      print('Error loading favorites: $e');
      _loadFavoritesFromCache();
    }
  }

  void _loadFavoritesFromCache() {
    try {
      final cacheBox = Hive.box('characters_cache');
      final cachedData = cacheBox.get('cached_characters');
      if (cachedData != null) {
        final List<Character> allCharacters =
            (cachedData as List).map((e) => Character.fromJson(e)).toList();
        favorites.value = allCharacters
            .where((c) => _favoritesBox.containsKey(c.id))
            .toList();
        _sortFavorites();
      }
    } catch (e) {
      print('Error loading favorites from cache: $e');
    }
  }

  void setSortBy(String sortType) {
    sortBy.value = sortType;
    _sortFavorites();
  }

  void _sortFavorites() {
    switch (sortBy.value) {
      case 'name':
        favorites.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'status':
        favorites.sort((a, b) => a.status.compareTo(b.status));
        break;
      case 'species':
        favorites.sort((a, b) => a.species.compareTo(b.species));
        break;
    }
    favorites.refresh();
  }
}

