
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchModule extends StatefulWidget {
  const SearchModule({super.key});

  @override
  State<SearchModule> createState() => _SearchModuleState();
}

class _SearchModuleState extends State<SearchModule> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
          child: SearchBar(),
      ),
    );
  }
}
