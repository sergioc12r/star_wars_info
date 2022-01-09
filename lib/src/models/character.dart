import 'package:equatable/equatable.dart';

class Character extends Equatable{

  final String? name;
  final String? skinColor;
  final String? eyeColor;
  final String? hairColor;
  final String? gender;
  final String? birthYear;

  const Character({this.name, this.skinColor, this.eyeColor, this.hairColor, this.gender, this.birthYear});

  @override
  List<Object?> get props => [name,skinColor,eyeColor,hairColor];

  factory Character.fromJson(Map<String,dynamic> json){
    return Character(
      name: json['name'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      hairColor: json['hair_color'],
      gender: json['gender'],
      birthYear: json['birth_year'],
    );
  }

}