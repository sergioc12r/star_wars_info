import 'package:star_wars_info/src/common/utils/env/environment.dart';
import 'package:star_wars_info/src/resources/repository.dart';

class Utils{

  static Repository? get repository => _repository;

  static Repository? _repository;

  static void inject({required Repository? repository}) => _repository = repository;

  static const Environment environment = Environment.production;

  static String urlImageBase = 'https://image.tmdb.org/t/p/w200';
}