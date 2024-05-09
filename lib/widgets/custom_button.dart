import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({required this.text, required this.onTap});
 final  VoidCallback? onTap;
  final Text? text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        maximumSize: Size(double.infinity, 150),
        padding: EdgeInsets.symmetric(horizontal: 160, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: text,
    );
  }
}
