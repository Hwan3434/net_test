import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';

/// Flutter framework class입니다.
/// 문제점 1. 이 데이터는 네트워크 상태모델로 구현해야 하는가? → 놉 ! 순수데이터만을 구현해야한다 생각한다.
/// 그럼 네트워크상태를 구현하는건 ViewModel에서 해주도록 하자
/// 문제점 2. 매번 서버를 통해 새로불러와야하는 데이터에는 이 클래스를 사용하면 안된다.
/// 문제점 3. 초기화가 필요한 모델을 가질때 null로 처리 할 것인가 ?(final은 빼도된다. 상관없다.)
/// 문제점 4. 데이터 삽입, 삭제, 초기화 등은 어디에서 진행 할 것인가?
class UserDataNotifier extends ChangeNotifier {
  final Set<UserDataModel> data = {};

  int get size => _size;
  int _size = 0;

  void add(UserDataModel model) {
    if (data.contains(model)) {
      delete(model.id);
    }
    final success = data.add(model);
    if (success) {
      _size++;
      notifyListeners();
    }
  }

  /// 요녀석 clear는 아니고... add이긴한데
  /// 없음 insert 있으면 delete 후 insert 혹은 update
  /// 근데 그럼 1개 할때마다 notifyListeners(); 호출됨
  void addAll(List<UserDataModel> model) {
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
