import 'package:flutter/material.dart';

class BTextField extends StatelessWidget {
  final TextEditingController? controller;

  const BTextField({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.green,
      ),
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        prefixIcon: Icon(Icons.phone),
        suffixIcon: Icon(Icons.star),
        hintText: 'Hint Text',
        labelText: 'Label Text',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
