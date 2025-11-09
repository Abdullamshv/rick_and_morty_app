import 'package:dio/dio.dart';
import '../models/character_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Map<String, dynamic>> getCharacters({int page = 1}) async {
    try {
      final response = await _dio.get('/character', queryParameters: {
        'page': page,
      });

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List;
        final characters = results
            .map((json) => Character.fromJson(json as Map<String, dynamic>))
            .toList();

        return {
          'characters': characters,
          'hasNextPage': data['info']['next'] != null,
          'totalPages': (data['info']['pages'] as num).toInt(),
        };
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      throw Exception('Error fetching characters: $e');
    }
  }

  Future<Character> getCharacterById(int id) async {
    try {
      final response = await _dio.get('/character/$id');

      if (response.statusCode == 200) {
        return Character.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load character');
      }
    } catch (e) {
      throw Exception('Error fetching character: $e');
    }
  }
}

