import 'package:flutter/material.dart';

class CustomTextResultWidget extends StatelessWidget {
  const CustomTextResultWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
