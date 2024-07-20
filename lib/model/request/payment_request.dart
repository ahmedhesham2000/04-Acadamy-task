// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentRequest {
  String cardNumber;
  String expDate;
  String cvv;
  String cardHolder;
  PaymentRequest({
    required this.cardNumber,
    required this.expDate,
    required this.cvv,
    required this.cardHolder,
  });

  PaymentRequest copyWith({
    String? cardNumber,
    String? expDate,
    String? cvv,
    String? cardHolder,
  }) {
    return PaymentRequest(
      cardNumber: cardNumber ?? this.cardNumber,
      expDate: expDate ?? this.expDate,
      cvv: cvv ?? this.cvv,
      cardHolder: cardHolder ?? this.cardHolder,
    );
  }

  Map<String, dynamic> toMap({required int formId}) {
    return <String, dynamic>{
      "card_number": cardNumber,
      "cvc": cvv,
      "exp_date": expDate,
      "card_holder": cardHolder,
      "form": formId
    };
  }

  factory PaymentRequest.fromMap(Map<String, dynamic> map) {
    return PaymentRequest(
      cardNumber: map['cardNumber'] as String,
      expDate: map['expDate'] as String,
      cvv: map['cvv'] as String,
      cardHolder: map['cardHolder'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  factory PaymentRequest.fromJson(String source) =>
      PaymentRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentRequest(cardNumber: $cardNumber, expDate: $expDate, cvv: $cvv, cardHolder: $cardHolder)';
  }

  @override
  bool operator ==(covariant PaymentRequest other) {
    if (identical(this, other)) return true;

    return other.cardNumber == cardNumber &&
        other.expDate == expDate &&
        other.cvv == cvv &&
        other.cardHolder == cardHolder;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
        expDate.hashCode ^
        cvv.hashCode ^
        cardHolder.hashCode;
  }
}
