import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/characters.dart';
import '../data/repositry/characters_repositry.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepositry charactersRepositry;
   List<Character> characters=[];
  CharactersCubit(this.charactersRepositry) : super(CharactersInitial());

  List<Character> getAllCharacters(){
    charactersRepositry.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;
  }
}
