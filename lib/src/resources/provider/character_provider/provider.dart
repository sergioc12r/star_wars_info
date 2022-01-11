import 'package:http/http.dart';
import 'package:star_wars_info/src/resources/provider/character_provider/character_api_provider.dart';

class CharacterProvider{

  CharacterProvider(this.client){
    characters = CharacterApiProvider(client);
  }

  final Client client;

  CharacterApiProvider? characters;

}