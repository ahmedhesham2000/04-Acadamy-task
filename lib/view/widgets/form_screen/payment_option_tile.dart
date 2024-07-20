import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';

class PaymentOptionTile extends StatelessWidget {
  const PaymentOptionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ratio * 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),

          Text(
            'بطاقة إئتمان',
            style: TextStyle(fontSize: textSize * 18.0),
          ),
          const Spacer(),
          // Visa logo
          Image.asset(
            'assets/images/visa.png', // replace with actual URL
            width: ratio * 40,
            height: ratio * 40,
          ),
          SizedBox(width: ratio * 8.0),
          // MasterCard logo
          Image.asset(
            'assets/images/mc.png', // replace with actual URL
            width: ratio * 40,
            height: ratio * 40,
          ),
          SizedBox(width: ratio * 8.0),
          // American Express logo
          Image.asset(
            'assets/images/amex.png', // replace with actual URL
            width: ratio * 40,
            height: ratio * 40,
          ),
        ],
      ),
    );
  }
}
