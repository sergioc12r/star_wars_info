import 'package:equatable/equatable.dart';
import 'package:star_wars_info/src/models/origin.dart';
import 'package:star_wars_info/src/models/response/location.dart';

class Character extends Equatable{

  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final String? image;
  final Location? location;
  final Origin? origin;

  const Character({this.id,this.name, this.status, this.species, this.type, this.gender, this.image, this.location, this.origin});

  @override
  List<Object?> get props => [id,name,status,species,type,gender,image,location,origin];

  factory Character.fromJson(Map<String,dynamic> json){
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      location: Location.fromJson(json['location']),
      origin: Origin.fromJson(json['origin']),
    );
  }

}