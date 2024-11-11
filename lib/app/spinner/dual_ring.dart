import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';

class DualRing extends StatelessWidget {
  const DualRing({
    super.key,
    this.message = 'Cargando',
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: HexColor('#ffffff'),
        boxShadow: shadowLoginContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitDualRing(
            color: HexColor('#29a19a'),
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 25),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}

const shadowLoginContainer = [
  BoxShadow(
    offset: Offset(10, 10),
    blurRadius: 10,
    color: Color(0xFF447c94),
  ),
  BoxShadow(
    offset: Offset(-10, -10),
    blurRadius: 10,
    color: Color(0xFF5989a4),
  ),
];
