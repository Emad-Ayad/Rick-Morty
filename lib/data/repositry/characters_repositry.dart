import 'package:rick_morty/data/api/characters_api.dart';

import '../models/characters.dart';

class CharactersRepositry {
  final CharactersApi charactersApi;

  CharactersRepositry(this.charactersApi);

  Future<List<Character>> getAllCharacters() async {
    final charactersJson = await charactersApi.getAllCharacters();
    return charactersJson;
  }
}
