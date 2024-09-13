import 'package:dio/dio.dart';
import 'package:rick_morty/consts/strings.dart';

import '../models/characters.dart';

class CharactersApi {
  late Dio dio;

  CharactersApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    );
    dio = Dio(options);
  }

  Future<List<Character>> getAllCharacters() async {
    try {
      Response response = await dio.get("character");
      Map<String, dynamic> data = response.data;
      List<dynamic> results = data['results'];
      return results
          .map<Character>(
              (json) => Character.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching characters: ${e.toString()}');
      return [];
    }
  }
}

// class CharactersApi {
//   final Dio dio = Dio();
//   final String apiUrl = 'https://rickandmortyapi.com/api/character/';
//
//   Future<List<dynamic>> getAllCharacters() async {
//     try {
//       final response = await dio.get(apiUrl);
//
//       if (response.statusCode == 200) {
//         final jsonResponse = response.data as Map<String, dynamic>;
//
//         // Check if 'results' is present and not null
//         if (jsonResponse['results'] != null) {
//           return jsonResponse['results'] as List<dynamic>;
//         } else {
//           throw Exception('Results not found in the API response');
//         }
//       } else {
//         throw Exception('Failed to load characters');
//       }
//     } catch (e) {
//       throw Exception('Failed to load characters: $e');
//     }
//   }
// }
