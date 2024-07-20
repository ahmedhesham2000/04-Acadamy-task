// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Subscription {
  int? id;
  String? enTerm;
  String? arTerm;
  String? discount;
  String? price;
  String? enPeriod;
  String? arPeriod;
  String? forData;
  bool isSelected = false;
  Subscription({
    this.id,
    this.enTerm,
    this.arTerm,
    this.discount,
    this.price,
    this.enPeriod,
    this.arPeriod,
    this.forData,
    this.isSelected = false,
  });

  Subscription copyWith({
    int? id,
    String? enTerm,
    String? arTerm,
    String? discount,
    String? price,
    String? enPeriod,
    String? arPeriod,
    String? forData,
    bool? isSelected,
  }) {
    return Subscription(
      id: id ?? this.id,
      enTerm: enTerm ?? this.enTerm,
      arTerm: arTerm ?? this.arTerm,
      discount: discount ?? this.discount,
      price: price ?? this.price,
      enPeriod: enPeriod ?? this.enPeriod,
      arPeriod: arPeriod ?? this.arPeriod,
      forData: forData ?? this.forData,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'enTerm': enTerm,
      'arTerm': arTerm,
      'discount': discount,
      'price': price,
      'enPeriod': enPeriod,
      'arPeriod': arPeriod,
      'forData': forData,
      'isSelected': isSelected,
    };
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'] != null ? map['id'] as int : null,
      enTerm: map['term'] != null ? map['term'] as String : null,
      arTerm: map['term_arabic'] != null ? map['term_arabic'] as String : null,
      discount: map['discount'] != null ? map['discount'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      enPeriod: map['period'] != null ? map['period'] as String : null,
      arPeriod:
          map['period_arabic'] != null ? map['period_arabic'] as String : null,
      forData: map['forData'] != null ? map['forData'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subscription.fromJson(String source) =>
      Subscription.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Subscription(id: $id, enTerm: $enTerm, arTerm: $arTerm, discount: $discount, price: $price, enPeriod: $enPeriod, arPeriod: $arPeriod, forData: $forData, isSelected: $isSelected)';
  }

  @override
  bool operator ==(covariant Subscription other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.enTerm == enTerm &&
        other.arTerm == arTerm &&
        other.discount == discount &&
        other.price == price &&
        other.enPeriod == enPeriod &&
        other.arPeriod == arPeriod &&
        other.forData == forData &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        enTerm.hashCode ^
        arTerm.hashCode ^
        discount.hashCode ^
        price.hashCode ^
        enPeriod.hashCode ^
        arPeriod.hashCode ^
        forData.hashCode ^
        isSelected.hashCode;
  }
}
