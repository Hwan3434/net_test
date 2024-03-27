part of 'state_test_widget.dart';

class _StateCountWidget extends ConsumerWidget
    with StateTestState, StateTestEvent {
  const _StateCountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('숫자 위젯 업데이트 합니다.');
    int count = watchCount(ref);
    return TextCommandWidget('count : $count');
  }
}
