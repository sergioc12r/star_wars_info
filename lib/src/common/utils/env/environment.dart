import 'package:star_wars_info/src/common/utils/env/secrets.dart';

class Environment{

  const Environment({this.starWarsDb});

  final String? starWarsDb;

  static const production =
  Environment(
    starWarsDb: ApiEnvironmentStarWars.production,
  );
}