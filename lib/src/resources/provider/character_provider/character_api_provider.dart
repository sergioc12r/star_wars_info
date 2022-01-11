import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:star_wars_info/src/models/character.dart';
import 'package:star_wars_info/src/models/response/api_response.dart';
import 'package:star_wars_info/src/models/response/paginated_response.dart';
import 'package:star_wars_info/src/models/response/pagination.dart';
import 'package:star_wars_info/src/resources/provider/character_provider/character_api_service.dart';

class CharacterApiProvider extends CharacterApiService{

  CharacterApiProvider(Client client) : super(client);

  Future<PaginatedResponse<Character,String>?>? fetchCharacterList({int? page, String? url}) async{
    try {
      String endpoint = '';
      if(page!= null) endpoint = '$root/character?page=$page';
      else endpoint = url ?? '';
      var response = await client.get(Uri.parse(endpoint));
      if(response.statusCode == 404) return PaginatedResponse(body: <Character>[], pagination: Pagination());
      if(response.statusCode != 200) return PaginatedResponse(body: <Character>[]);
      var parsedJson = json.decode(response.body);
      Iterable i = parsedJson['results'];
      var characters = i.map((character) => Character.fromJson(character)).toList();
      return PaginatedResponse(
        pagination: Pagination.fromJson(parsedJson['info']),
        body: characters,
      );
    } catch (e) {
      debugPrint("error on fetchCharacterList");
      return PaginatedResponse(body: <Character>[],pagination: null);
    }
  }

  Future<ApiResponse<Character>> fetchCharacterDetail({int? charId}) async{
    try {
      var response = await client.get(Uri.parse('$root/people/$charId?'));
      if(response.statusCode != 200) return ApiResponse(statusCode: response.statusCode, success: false);
      var parsedJson = json.decode(response.body);
      return ApiResponse(
          success: true,
          statusCode: response.statusCode,
          body:  Character.fromJson(parsedJson)
      );
    } catch (e) {
      debugPrint("error on fetchCharacterDetail");
      return ApiResponse(statusCode: 500, success: false);
    }
  }

}