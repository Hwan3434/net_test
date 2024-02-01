import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/base/consumer_base/base_define.dart';

abstract class BaseConsumerStatefulWidget<VM> extends ConsumerStatefulWidget
    with BaseMapBuilderDefine<VM> {
  BaseConsumerStatefulWidget({super.key});

  ProviderListenable<VM> get viewProvider;

  @override
  ConsumerState<BaseConsumerStatefulWidget> createState();
}
