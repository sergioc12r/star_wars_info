part of 'character_detail_bloc.dart';

abstract class CharacterDetailState extends Equatable{
  const CharacterDetailState();

  @override
  List<Object?> get props => [];
}

class LoadingCharacterDetailState extends CharacterDetailState{}

class FetchCharacterDetailState extends CharacterDetailState{}

class ErrorCharacterDetailState extends CharacterDetailState{}