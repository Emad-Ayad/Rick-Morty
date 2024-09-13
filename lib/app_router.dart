import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/data/api/characters_api.dart';
import 'package:rick_morty/data/repositry/characters_repositry.dart';
import 'package:rick_morty/ui/screens/character_screen.dart';

import 'bloc/characters_cubit.dart';
import 'consts/strings.dart';
import 'data/models/characters.dart';

class AppRouter {
  late CharactersRepositry charactersRepositry;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepositry = CharactersRepositry(CharactersApi());
    charactersCubit = CharactersCubit(charactersRepositry);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => charactersCubit,
            child: CharacterScreen(),
          ),
        );

    }
  }
}