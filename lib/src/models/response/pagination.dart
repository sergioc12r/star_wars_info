import 'package:equatable/equatable.dart';

class Pagination extends Equatable {

  final int? count;
  final String? next;
  final String? previous;

  const Pagination({this.count, this.next, this.previous}) : super();
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
    );
  }

  bool? get isFirstPage => previous == null;
  bool? get isLastPage => next == null;

  @override
  List<Object?> get props => [count, next, previous];
}