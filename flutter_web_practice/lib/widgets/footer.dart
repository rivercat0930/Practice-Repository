import 'package:flutter/material.dart';
import 'package:flutter_web_practice/constants/colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      width: double.maxFinite,
      alignment: Alignment.center,
      child: const Text(
        'Following the Shohruh AK\'s video and practice it',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: CustomColor.whiteSecondary,
        ),
      ),
    );
  }
}
