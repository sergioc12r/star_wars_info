import 'dart:io';

import 'package:flutter/material.dart';
import 'package:star_wars_info/src/common/utils/utils.dart';
import 'package:star_wars_info/src/resources/repository.dart';
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
      title: 'Flutter Timer',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(109, 234, 255, 1),
        colorScheme: const ColorScheme.light(
          secondary: Color.fromRGBO(72, 74, 126, 1),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
