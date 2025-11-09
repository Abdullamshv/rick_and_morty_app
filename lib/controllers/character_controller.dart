import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class CharacterController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxList<Character> characters = <Character>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString error = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasNextPage = true.obs;

  static const String _cacheBoxName = 'characters_cache';
  static const String _charactersBoxName = 'characters';
  static const String _cacheKey = 'cached_characters';
  static const String _pageKey = 'current_page';
  late Box _cacheBox;
  late Box<Character> _charactersBox;

  @override
  void onInit() async {
    super.onInit();
    await _initBoxes();
    _loadCachedData();
    fetchCharacters();
  }

  Future<void> _initBoxes() async {
    _cacheBox = await Hive.openBox(_cacheBoxName);
    _charactersBox = await Hive.openBox<Character>(_charactersBoxName);
  }

  Future<void> _loadCachedData() async {
    try {
      final cachedData = _cacheBox.get(_cacheKey);
      final cachedPage = _cacheBox.get(_pageKey, defaultValue: 1);

      if (cachedData != null) {
        final List<Character> cachedCharacters =
            (cachedData as List).map((e) => Character.fromJson(e)).toList();
        characters.value = cachedCharacters;
        currentPage.value = cachedPage as int;
        
        // Also store in characters box for favorites access
        for (var character in cachedCharacters) {
          await _charactersBox.put(character.id, character);
        }
      }
    } catch (e) {
      print('Error loading cached data: $e');
    }
  }

  Future<void> _saveToCache() async {
    try {
      final jsonList = characters.map((c) => c.toJson()).toList();
      await _cacheBox.put(_cacheKey, jsonList);
      await _cacheBox.put(_pageKey, currentPage.value);
      
      // Also store in characters box for favorites access
      for (var character in characters) {
        await _charactersBox.put(character.id, character);
      }
    } catch (e) {
      print('Error saving to cache: $e');
    }
  }

  Future<void> fetchCharacters({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasNextPage.value || isLoadingMore.value) return;
      isLoadingMore.value = true;
    } else {
      if (isLoading.value) return;
      isLoading.value = true;
      currentPage.value = 1;
      hasNextPage.value = true;
    }

    error.value = '';

    try {
      final result = await _apiService.getCharacters(page: currentPage.value);

      final newCharacters = result['characters'] as List<Character>;
      
      if (loadMore) {
        characters.addAll(newCharacters);
      } else {
        characters.value = newCharacters;
      }

      hasNextPage.value = result['hasNextPage'] as bool;
      currentPage.value = currentPage.value + 1;

      // Store characters in Hive box for favorites access
      for (var character in newCharacters) {
        await _charactersBox.put(character.id, character);
      }
      
      await _saveToCache();
    } catch (e) {
      error.value = e.toString();
      if (!loadMore) {
        // If initial load fails, keep cached data
      }
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMoreCharacters() async {
    if (hasNextPage.value && !isLoadingMore.value) {
      await fetchCharacters(loadMore: true);
    }
  }

  void refreshCharacters() {
    currentPage.value = 1;
    hasNextPage.value = true;
    fetchCharacters();
  }
}

