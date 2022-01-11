import 'package:equatable/equatable.dart';

class Origin extends Equatable{

  final String? url;
  final String? name;

  const Origin({this.url, this.name});

  @override
  List<Object?> get props => [url,name];

  factory Origin.fromJson(Map<String,dynamic> json){
    return Origin(
      url: json['url'],
      name: json['name'],
    );
  }
}