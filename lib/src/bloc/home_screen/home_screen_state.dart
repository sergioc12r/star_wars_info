part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  HomeScreenState([List props = const []]):super();
}

class LoadingHomeScreenState extends HomeScreenState {
  LoadingHomeScreenState(): super();
  @override
  List<Object?> get props => [];
}

class FetchedHomeScreenState extends HomeScreenState {
  final bool? isLoading;
  final Pagination? pagination;
  FetchedHomeScreenState({
    this.isLoading: false,
    this.pagination,
  }): super();
  @override
  List<Object?> get props => [isLoading,pagination,UniqueKey()];
}

class ErrorHomeScreenState extends HomeScreenState {
  ErrorHomeScreenState() : super();
  @override
  List<Object?> get props => [];
}