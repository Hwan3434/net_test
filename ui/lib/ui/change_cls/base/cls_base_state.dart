import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cls_map_builder_define.dart';

abstract class ClsBaseState<T extends ConsumerStatefulWidget, M>
    extends ConsumerState<T> with ClsMapBuilderDefine<M> {
  @override
  void initState() {
    super.initState();
    initializeWidgetMap();
  }
}
