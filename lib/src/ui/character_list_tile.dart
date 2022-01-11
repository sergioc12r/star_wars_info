import 'package:flutter/material.dart';
import 'package:star_wars_info/src/models/character.dart';

class CharacterListTile extends StatelessWidget{

  final Character? character;

  const CharacterListTile({Key? key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      return ListTile(
        onTap: ()=>_onTap(context),
        title: Text(character?.name ?? ''),
        subtitle: Text(character?.status ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios),
      );
    });
  }

  _onTap(BuildContext context)=> print("push to ${character?.name}");

}