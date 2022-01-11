part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable{
  const HomeScreenEvent();
  @override
  List<Object?> get props => [];
}

class LoadDataHomeScreenEvent extends HomeScreenEvent{
  const LoadDataHomeScreenEvent();
}

class RequestPage extends HomeScreenEvent{
  final int? page;
  RequestPage(this.page) : super();
}

class RequestNewPage extends HomeScreenEvent {}

