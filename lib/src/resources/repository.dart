import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:star_wars_info/src/models/character.dart';
import 'package:star_wars_info/src/models/response/api_response.dart';
import 'package:star_wars_info/src/models/response/paginated_response.dart';
import 'package:star_wars_info/src/resources/provider/character_provider/provider.dart';

class Repository{

  static final RetryClient client = RetryClient(Client(), retries: 2);

  final CharacterProvider _provider = CharacterProvider(client);

  Future<PaginatedResponse<Character,String>?>? fetchCharacterList({int? page,String? url}){
    return _provider.characters?.fetchCharacterList(page: page, url: url);
  }

  Future<ApiResponse<Character>>? fetchCharacter({int? charId}){
    return _provider.characters?.fetchCharacterDetail(charId: charId);
  }

}