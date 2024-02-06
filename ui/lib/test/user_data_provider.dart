import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';

/// Flutter framework class입니다.
/// 문제점 1. 이 데이터는 네트워크 상태모델로 구현해야 하는가? → 놉 ! 순수데이터만을 구현해야한다 생각한다.
/// 그럼 네트워크상태를 구현하는건 ViewModel에서 해주도록 하자
/// 문제점 2. 매번 서버를 통해 새로불러와야하는 데이터에는 이 클래스를 사용하면 안된다.
class UserDataNotifier extends ChangeNotifier {
  final Set<UserModel> data = {};

  int get size => _size;
  int _size = 0;

  void add(UserModel model) {
    final success = data.add(model);
    if (success) {
      _size++;
      notifyListeners();
    }
  }

  void addAll(List<UserModel> model) {
    data.addAll(model);
    _size = data.length;
    notifyListeners();
  }

  void delete(int id) {
    bool success = false;
    data.removeWhere((element) {
      if (success != true) {
        success = element.id == id;
      }
      return element.id == id;
    });
    if (success) {
      _size--;
      notifyListeners();
    }
  }
}
