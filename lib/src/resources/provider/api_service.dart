import 'package:http/http.dart';

abstract class ApiService{
  final Client client;

  ApiService(this.client);

  String get root;
}