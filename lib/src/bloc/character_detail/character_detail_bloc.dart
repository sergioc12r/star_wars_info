import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_info/src/common/utils/utils.dart';
import 'package:star_wars_info/src/models/character.dart';
import 'package:star_wars_info/src/models/response/api_response.dart';
import 'package:star_wars_info/src/resources/repository.dart';

part 'character_detail_state.dart';
part 'character_detail_event.dart';


class CharacterDetailBloc extends Bloc<CharacterDetailEvent,CharacterDetailState>{

  final Character? insideCharacter;

  CharacterDetailBloc({this.insideCharacter}) : super(LoadingCharacterDetailState()){
    on<LoadCharacterDetailEvent>(_onStarted);
  }

  Character? character;
  final Repository? _repo = Utils.repository;

  void _onStarted(LoadCharacterDetailEvent event, Emitter<CharacterDetailState> emit)async{
    emit(LoadingCharacterDetailState());
    ApiResponse<Character>? response = await  _repo?.fetchCharacter(charId: insideCharacter?.id);
    if(response?.failure ?? true){
      emit(ErrorCharacterDetailState());
      return;
    }
    character = response?.body;
    emit(FetchCharacterDetailState());
  }
}