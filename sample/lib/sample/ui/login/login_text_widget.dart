import 'package:flutter/material.dart';

typedef Validate = ValidateModel Function(String text);

class LoginTextWidget extends StatelessWidget {
  final String text;
  final Validate validateFn;
  const LoginTextWidget(
    this.text, {
    super.key,
    required this.validateFn,
  });

  @override
  Widget build(BuildContext context) {
    final validateModel = validateFn(text);
    return !validateModel.success
        ? Text(
            'validate : ${validateModel.message}',
            style: TextStyle(
              color: validateModel.color,
            ),
          )
        : SizedBox();
  }
}

class ValidateModel {
  final bool success;
  final Color? color;
  final String? message;

  const ValidateModel({
    required this.success,
    this.color,
    this.message,
  });
}
