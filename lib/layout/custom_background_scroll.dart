import 'package:flutter/material.dart';

class CustomBackgroundScroll extends StatelessWidget {
  const CustomBackgroundScroll(this.childElement, {Key? key}) : super(key: key);
  final dynamic childElement;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: childElement,
      ),
    );
  }
}
