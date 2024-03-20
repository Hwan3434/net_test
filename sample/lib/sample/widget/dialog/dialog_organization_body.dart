import 'package:flutter/material.dart';

class DialogOrganizationBody extends StatelessWidget {
  final String organization;
  const DialogOrganizationBody({
    required this.organization,
  });

  @override
  Widget build(BuildContext context) {
    return Text('"$organization" 조직으로 접근 하시겠습니까?');
  }
}
