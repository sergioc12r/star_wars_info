import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_info/src/common/utils/utils.dart';
import 'package:star_wars_info/src/models/character.dart';
import 'package:star_wars_info/src/models/response/paginated_response.dart';
import 'package:star_wars_info/src/models/response/pagination.dart';
import 'package:star_wars_info/src/resources/repository.dart';

part 'home_screen_state.dart';
part 'home_screen_event.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {

  HomeScreenBloc() : super(LoadingHomeScreenState()) {
    on<LoadDataHomeScreenEvent>(_onStarted);
    on<RequestPage>(_requestPage);
    on<RequestNewPage>(_requestNewPage);
  }

  int? initialPage = 1;
  Pagination? pagination;

  List<Character>? allCharacters =[];
  final Repository? repository = Utils.repository;

  void _onStarted(LoadDataHomeScreenEvent event, Emitter<HomeScreenState> emit)async{
    emit(LoadingHomeScreenState());
    add(RequestPage(1));
  }

  void _requestPage(RequestPage event, Emitter<HomeScreenState> emit)async{
    if(state is FetchedHomeScreenState)
      emit(FetchedHomeScreenState(pagination: pagination,isLoading: true));
    dynamic fetch = await fetchPage(event.page ?? initialPage, null);
    if(fetch == null || pagination == null){
      emit(ErrorHomeScreenState());
      return;
    }
    allCharacters = fetch ?? [];
    emit(FetchedHomeScreenState(pagination: pagination,isLoading: false));
  }

  void _requestNewPage(RequestNewPage event, Emitter<HomeScreenState> emit)async{
    debugPrint('NewPage');
    if(pagination?.isLastPage ?? false) return;
    if(state is FetchedHomeScreenState)
      emit(FetchedHomeScreenState(pagination: pagination,isLoading: true));
    dynamic fetch = await fetchPage(null, pagination?.next);
    if(fetch == null || pagination == null){
      emit(ErrorHomeScreenState());
      return;
    }
    allCharacters?.addAll(fetch);
    emit(FetchedHomeScreenState(pagination: pagination,isLoading: false));
  }

  Future<List<Character>?>? fetchPage(int? page, String? url)async{
    PaginatedResponse<Character,String>? response = await repository?.fetchCharacterList(page: page, url: url);
    pagination = response?.pagination;
    if(pagination == null) return null;
    return response?.body ?? <Character>[];
  }


}