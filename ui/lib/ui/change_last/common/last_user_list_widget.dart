import 'dart:math';

import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';

class LastUserListWidget extends StatelessWidget {
  final List<UserDataModel> data;

  const LastUserListWidget({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _LastUserItemWidget(data: data[index]);
      },
    );
  }
}

class _LastUserItemWidget extends StatelessWidget {
  final UserDataModel data;
  const _LastUserItemWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      child: Center(
        child: Text(data.name),
      ),
    );
  }
}
