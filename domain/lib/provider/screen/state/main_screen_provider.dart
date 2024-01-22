import 'package:domain/provider/screen/model/main_screen_model.dart';
import 'package:riverpod/riverpod.dart';

class MainScreenProvider extends StateNotifier<MainScreenModel> {
  MainScreenProvider()
      : super(MainScreenModel(
          title: '',
          description: '',
          imagePath: '',
        ));


  factory MainScreenProvider.create() {
    return MainScreenProvider();
  }

}
