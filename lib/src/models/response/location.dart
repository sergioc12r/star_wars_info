import 'package:equatable/equatable.dart';

class Location extends Equatable{

  final String? url;
  final String? name;

  const Location({this.url, this.name});

  @override
  List<Object?> get props => [url,name];

  factory Location.fromJson(Map<String,dynamic> json){
    return Location(
      url: json['url'],
      name: json['name'],
    );
  }
}