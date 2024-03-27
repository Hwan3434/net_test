import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/state_test/state_name_widget.dart';
import 'package:sample/sample/ui/state_test/widget/text_command.dart';
import 'package:sample/sample/util/log.dart';

part 'state_changed_widget.dart';
part 'state_count_widget.dart';
part 'state_event.dart';
part 'state_test.dart';
part 'state_test_provider.dart';

class StateTestWidget extends ConsumerWidget
    with StateTestState, StateTestEvent {
  const StateTestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('전체 위젯 업데이트 합니다.');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StateChangedWidget(),
          _StateCountWidget(),
          StateNameWidget(),
        ],
      ),
    );
  }
}
