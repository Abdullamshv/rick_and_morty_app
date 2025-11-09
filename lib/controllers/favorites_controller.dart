import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/character_model.dart';

class FavoritesController extends GetxController {
  static const String _favoritesBoxName = 'favorites';
  late Box<int> _favoritesBox;

  final RxList<Character> favorites = <Character>[].obs;
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
    loadFavorites();
  }

  Future<void> addFavorite(Character character) async {
    await _favoritesBox.put(character.id, character.id);
    favoriteIds.add(character.id);

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

  /// Сортировка только по имени (A–Z, без учёта регистра)
  void _sortFavorites() {
    favorites.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    favorites.refresh();
  }

  /// Метод сохранён только для совместимости с экраном FavoritesScreen
  void setSortBy(String sortType) {
    _sortFavorites();
  }
}
