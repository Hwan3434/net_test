import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'wrapper_map_builder_define.dart';

abstract class WrapperConsumerStatefulWidget<VM> extends ConsumerStatefulWidget
    with WrapperMapBuilderDefine<VM> {
  WrapperConsumerStatefulWidget({super.key});

  ProviderListenable<VM> get viewProvider;

  @override
  ConsumerState<WrapperConsumerStatefulWidget> createState();
}
