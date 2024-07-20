// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class Materials {
  int? id;
  String? enName;
  String? arName;
  String? forData;
  String? image;
  bool? isSelected = false;
  Materials({
    this.id,
    this.enName,
    this.arName,
    this.forData,
    this.image,
    this.isSelected,
  });

  Materials copyWith({
    int? id,
    String? enName,
    String? arName,
    String? forData,
    String? image,
    bool? isSelected,
  }) {
    return Materials(
      id: id ?? this.id,
      enName: enName ?? this.enName,
      arName: arName ?? this.arName,
      forData: forData ?? this.forData,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'english_data': enName,
      'arabic_data': arName,
      'for_data': forData,
      'image': image,
    };
  }

  factory Materials.fromMap(Map<String, dynamic> map) {
    List<int> bytes = utf8.encode(map['arabic_data']);
    String decodedData = utf8.decode(bytes);
    log('decodedData: $decodedData');

    return Materials(
        id: map['id'] != null ? map['id'] as int : null,
        enName:
            map['english_data'] != null ? map['english_data'] as String : null,
        arName:
            map['arabic_data'] != null ? map['arabic_data'] as String : null,
        forData: map['for_data'] != null ? map['for_data'] as String : null,
        image: map['image'] != null ? map['image'] as String : null,
        isSelected: false);
  }

  String toJson() => json.encode(toMap());

  factory Materials.fromJson(String source) =>
      Materials.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Materials(id: $id, english_data: $enName, arabic_data: $arName, for_data: $forData, image: $image)';
  }

  @override
  bool operator ==(covariant Materials other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.enName == enName &&
        other.arName == arName &&
        other.forData == forData &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        enName.hashCode ^
        arName.hashCode ^
        forData.hashCode ^
        image.hashCode;
  }
}
