import 'package:flutter/material.dart';

class DiaryModel {
  final int id;
  final DiaryColor color;
  final DateTime date;
  final String content;
  final bool fav;
  final bool selectedState;
  final List<DiaryUserModel> users;
  final List<DiaryEtcModel> etc;

  const DiaryModel({
    required this.id,
    required this.color,
    required this.date,
    required this.content,
    required this.fav,
    required this.selectedState,
    required this.users,
    required this.etc,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum DiaryColor { red, green, blue, yellow }

extension DiaryColorExtention on DiaryColor {
  Color getColor() {
    switch (this) {
      case DiaryColor.red:
        return Colors.red;
      case DiaryColor.green:
        return Colors.green;
      case DiaryColor.blue:
        return Colors.blue;
      case DiaryColor.yellow:
        return Colors.yellow;
    }
  }
}

int createKey = 4;

class DiaryEtcModel {
  final int id;
  final String etc;
  final DateTime date;

  const DiaryEtcModel({
    required this.id,
    required this.etc,
    required this.date,
  });

  factory DiaryEtcModel.create() =>
      DiaryEtcModel(id: createKey++, etc: '', date: DateTime.now());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryEtcModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DiaryUserModel {
  final int id;
  final String name;
  final int age;

  const DiaryUserModel({
    required this.id,
    required this.name,
    required this.age,
  });

  factory DiaryUserModel.jj() => DiaryUserModel(id: 1, name: '징징이', age: 16);
  factory DiaryUserModel.nb() => DiaryUserModel(id: 2, name: '누비', age: 17);
  factory DiaryUserModel.gb() => DiaryUserModel(id: 3, name: '가비', age: 18);
  factory DiaryUserModel.wb() => DiaryUserModel(id: 4, name: '우비', age: 19);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryUserModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
