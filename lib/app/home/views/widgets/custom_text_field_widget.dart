import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          label: Text('Sua url longa'),
          suffixIcon: IconButton(
            onPressed: () {
              _textEditingController.clear();
            },
            icon: Icon(Icons.clear),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
