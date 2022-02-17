import 'package:flutter/material.dart';

class DefaultCircularProgressIndicators extends StatelessWidget {
  final double? value;
  final Color? color;
  final double strokeWidth;
  const DefaultCircularProgressIndicators({
    Key? key,
    this.value,
    this.color,
    this.strokeWidth = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      strokeWidth: strokeWidth,
      color: color,
      backgroundColor: Colors.transparent,
    );
  }
}
