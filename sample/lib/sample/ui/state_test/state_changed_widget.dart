part of 'state_test_widget.dart';

class _StateChangedWidget extends ConsumerStatefulWidget {
  const _StateChangedWidget({super.key});

  @override
  ConsumerState<_StateChangedWidget> createState() =>
      _StateChangedWidgetState();
}

class _StateChangedWidgetState extends ConsumerState<_StateChangedWidget>
    with StateTestState, StateTestEvent {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController testController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final name = readName(ref);
    nameController.text = name;
    nameController.addListener(() {
      updateName(
        ref,
        name: nameController.text,
      );
    });
    testController.addListener(() {
      updateTest(
        ref,
        test: testController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Log.d('텍스트 필드 위젯 업데이트 합니다.');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                countUp(ref);
              },
              child: Text('업'),
            ),
            ElevatedButton(
              onPressed: () {
                countDown(ref);
              },
              child: Text('다운'),
            ),
          ],
        ),
        TextField(
          controller: nameController,
        ),
        TextField(
          controller: testController,
        ),
      ],
    );
  }
}
