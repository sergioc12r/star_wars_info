import 'package:http/http.dart';
import 'package:star_wars_info/src/common/utils/utils.dart';
import 'package:star_wars_info/src/resources/provider/api_service.dart';

class CharacterApiService extends ApiService{

  CharacterApiService(Client client) : super(client);

  @override
  String get root => Utils.environment.starWarsDb ?? '';

}