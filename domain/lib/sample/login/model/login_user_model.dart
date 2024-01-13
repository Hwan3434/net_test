import 'package:data/sample/user/datasource/model/response/res_user_model.dart';

class LoginUserModel {
  final int id;
  final String name;

  LoginUserModel({
    required this.id,
    required this.name,
  });

  factory LoginUserModel.fromDataModel({
    required ResUserModel dataModel,
  }) {
    return LoginUserModel(
      id: dataModel.id,
      name: dataModel.name,
    );
  }
}
