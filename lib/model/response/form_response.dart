// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:test/utils/enums/enums.dart';

class FormResponse {
  int? id;
  String? firstName;
  String? familyName;
  int? age;
  Gender? gender;
  String? phone;
  String? email;
  bool? difficulties;
  String? description;
  String? nationality;
  FormResponse({
    this.id,
    this.firstName,
    this.familyName,
    this.age,
    this.gender,
    this.phone,
    this.email,
    this.difficulties,
    this.description,
    this.nationality,
  });

  FormResponse copyWith({
    int? id,
    String? firstName,
    String? familyName,
    int? age,
    Gender? gender,
    String? phone,
    String? email,
    bool? difficulties,
    String? description,
    String? nationality,
  }) {
    return FormResponse(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      familyName: familyName ?? this.familyName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      difficulties: difficulties ?? this.difficulties,
      description: description ?? this.description,
      nationality: nationality ?? this.nationality,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'familyName': familyName,
      'age': age,
      'gender': gender,
      'phone': phone,
      'email': email,
      'difficulties': difficulties,
      'description': description,
      'nationality': nationality,
    };
  }

  factory FormResponse.fromMap(Map<String, dynamic> map) {
    return FormResponse(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      familyName:
          map['family_name'] != null ? map['family_name'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      gender: map['gender'] != null
          ? (map['gender'] == 'Yes' ? Gender.Male : Gender.Female)
          : null,
      phone: map['Gender'] != null ? map['Gender'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      difficulties: map['difficulties'] != null
          ? map['difficulties'] == "Yes"
              ? true
              : false
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      nationality:
          map['nationality'] != null ? map['nationality'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormResponse.fromJson(String source) =>
      FormResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormResponse(id: $id, firstName: $firstName, familyName: $familyName, age: $age, gender: $gender, phone: $phone, email: $email, difficulties: $difficulties, description: $description, nationality: $nationality)';
  }

  @override
  bool operator ==(covariant FormResponse other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.familyName == familyName &&
        other.age == age &&
        other.gender == gender &&
        other.phone == phone &&
        other.email == email &&
        other.difficulties == difficulties &&
        other.description == description &&
        other.nationality == nationality;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        familyName.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        difficulties.hashCode ^
        description.hashCode ^
        nationality.hashCode;
  }
}
