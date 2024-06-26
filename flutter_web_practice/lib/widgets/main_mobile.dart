import 'package:flutter/material.dart';
import 'package:flutter_web_practice/constants/colors.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 30,
      ),
      height: screenHeight,
      constraints: const BoxConstraints(
        minHeight: 560,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // avatar image
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  CustomColor.scaffoldBg.withOpacity(0.6),
                  CustomColor.scaffoldBg.withOpacity(0.6),
                ],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              'assets/95602652.png',
              width: screenWidth,
            ),
          ),
          const SizedBox(height: 30),

          // intro text
          const Text(
            'Hi\nI\'m RiverCat\nA college student',
            style: TextStyle(
              fontSize: 24,
              height: 1.5,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
            ),
          ),
          const SizedBox(height: 15),

          // button
          SizedBox(
            width: 190,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Get in touch'),
            ),
          ),
        ],
      ),
    );
  }
}
