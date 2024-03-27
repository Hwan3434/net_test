import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/ui/state_test/state_test_widget.dart';
import 'package:sample/sample/util/log.dart';

class StateNameWidget extends ConsumerWidget
    with StateTestState, StateTestEvent {
  const StateNameWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('이름 위젯 업데이트 합니다.');
    final String name = watchName(ref);
    return Text('name : $name');
  }
}
