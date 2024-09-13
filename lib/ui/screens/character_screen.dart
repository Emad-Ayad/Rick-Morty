import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/characters_cubit.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;

  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildSerachField() {
    return TextField(
      style: TextStyle(color: Colors.black),
      controller: _searchTextController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: 'Search for Characters ...',
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: 18,
          )),
      onChanged: (searchedCharacters) {
        addSearchedForItemToSearchedList(searchedCharacters);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchedCharacters) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacters))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (_isSearching) {
      return [IconButton(onPressed: _clearSearch, icon: Icon(Icons.clear))];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).chracaters;
        return buildLoadedListWidget();
      } else {
        return showLoadedIndecator();
      }
    });
  }

  Widget showLoadedIndecator() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return CharacterItem(character:_searchTextController.text.isEmpty
              ? allCharacters[index] :searchedForCharacters[index] );
        });
  }

  Widget _buildAppBarTitle() {
    return Text(
      "Characters",
      style: TextStyle(color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: _isSearching ? _buildSerachField() : _buildAppBarTitle(),
        actions: _buildAppBarAction(),
      ),
      body: buildBlocWidget(),
    );
  }
}
