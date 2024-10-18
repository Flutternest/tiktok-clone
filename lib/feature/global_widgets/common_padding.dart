import 'package:flutter/material.dart';

class CommonPadding extends StatelessWidget {
  const CommonPadding({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: child,
    );
  }
}
