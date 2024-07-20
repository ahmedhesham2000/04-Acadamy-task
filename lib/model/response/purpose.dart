// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Purpose {
  int? id;
  String? enName;
  String? arName;
  String? forData;
  bool? isSelected;
  Purpose({
    this.id,
    this.enName,
    this.arName,
    this.forData,
    this.isSelected = false,
  });

  Purpose copyWith({
    int? id,
    String? enName,
    String? arName,
    String? forData,
    bool? isSelected,
  }) {
    return Purpose(
      id: id ?? this.id,
      enName: enName ?? this.enName,
      arName: arName ?? this.arName,
      forData: forData ?? this.forData,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'english_data': enName,
      'arabic_data': arName,
      'for_data': forData,
    };
  }

  factory Purpose.fromMap(Map<String, dynamic> map) {
    return Purpose(
      id: map['id'] != null ? map['id'] as int : null,
      enName:
          map['english_data'] != null ? map['english_data'] as String : null,
      arName: map['arabic_data'] != null ? map['arabic_data'] as String : null,
      forData: map['for_data'] != null ? map['for_data'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Purpose.fromJson(String source) =>
      Purpose.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Purpose(id: $id, english_data: $enName, arabic_data: $arName, for_data: $forData)';
  }

  @override
  bool operator ==(covariant Purpose other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.enName == enName &&
        other.arName == arName &&
        other.forData == forData;
  }

  @override
  int get hashCode {
    return id.hashCode ^ enName.hashCode ^ arName.hashCode ^ forData.hashCode;
  }
}
