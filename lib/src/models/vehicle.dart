import 'package:equatable/equatable.dart';

class Vehicle extends Equatable{

  final String? url;
  final String? name;
  final String? model;
  final String? manufacturer;

  const Vehicle({this.url, this.name, this.model, this.manufacturer});

  @override
  List<Object?> get props => [url, name, model, manufacturer];

  factory Vehicle.fromJson(Map<String, dynamic> json){
    return Vehicle(
      url: json['url'],
      name: json['name'],
      model: json['model'],
      manufacturer: json['manufacturer']
    );
  }

}