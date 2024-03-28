import 'package:test_web_view/web/base/controller/js_web_controller.dart';

class JsChannel<T> {
  final CreateChannelModel<T> createChannelModel;
  final JsChannelCallBack<T> channelCallBack;

  const JsChannel({
    required this.createChannelModel,
    required this.channelCallBack,
  });
}
