import 'package:domain/provider/screen/model/login_screen_model.dart';
import 'package:riverpod/riverpod.dart';

class LoginScreenProvider extends StateNotifier<LoginScreenModel> {
  LoginScreenProvider()
      : super(LoginScreenModel(
          email: '',
          password: '',
        ));


  factory LoginScreenProvider.create() {
    return LoginScreenProvider();
  }
}
