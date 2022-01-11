import 'dart:io';

import 'package:flutter/material.dart';
import 'package:star_wars_info/src/common/utils/colors.dart';
import 'package:star_wars_info/src/common/utils/utils.dart';
import 'package:star_wars_info/src/models/character.dart';
import 'package:star_wars_info/src/resources/repository.dart';
import 'package:star_wars_info/src/ui/character_detail_screen.dart';
import 'package:star_wars_info/src/ui/home_screen.dart';

void main()async{
  HttpOverrides.global = MyHttpOverrides();
  await _injectDependencies();
  runApp(MyApp());
}

_injectDependencies() {
  var repository = Repository();
  Utils.inject(repository: repository);
}

class MyHttpOverrides extends HttpOverrides{

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert,String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Rick and Morty',
      onGenerateRoute: (settings) {
        if (settings.name == '/detail');
          Character args = settings.arguments as Character;
          return MaterialPageRoute(
            builder: (context) {
              return CharacterDetailScreen(
                character: args);
            },
          );
      },
      theme: ThemeData(
        primaryColor: PrivateColors.title,
        secondaryHeaderColor: PrivateColors.paragraph,
        primaryColorDark: PrivateColors.paragraph,
        colorScheme: const ColorScheme.light(
          primary: PrivateColors.secondaryColor,
          secondary: PrivateColors.primaryColor,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
