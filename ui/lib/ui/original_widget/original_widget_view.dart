import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/original_widget/original_widget_view_notifier.dart';

class OriginalWidgetView extends ConsumerWidget {
  OriginalWidgetView({super.key});

  _EditContainer e = _EditContainer();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(originalWidgetViewProvider);
    return SafeArea(
      child: Column(
        children: [
          Container(
              color: Colors.red,
              child: InkWell(
                onTap: () {
                  final test = e.controller.text;
                  debugPrint('테텥 :: :${test}');
                },
                child: _TopCount(
                  provider: () {

                    return originalWidgetViewProvider
                        .select((value) => value.count);

                  },
                ),
              )),
          Expanded(
              child: Container(color: Colors.blue, child: _MainContainer())),
          Container(color: Colors.green, child: e),
        ],
      ),
    );
  }
}

class _TopCount extends ConsumerWidget {
  ProviderListenable Function() provider;
  _TopCount({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(provider.call());
    debugPrint('화면 새로고침 {count}');
    return Text('count = ${count}');
  }
}

class _MainContainer extends ConsumerWidget {
  const _MainContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text =
        ref.watch(originalWidgetViewProvider.select((value) => value.text));
    debugPrint('화면 새로고침 {채팅내용}');
    return Center(child: Text('채팅 내용 : $text'));
  }
}

class _EditContainer extends ConsumerStatefulWidget {
  _EditContainer({super.key});

  late TextEditingController controller;

  @override
  ConsumerState<_EditContainer> createState() {
    final a = _EditContainerState();
    controller = a.myController;
    return a;
  }
}

class _EditContainerState extends ConsumerState<_EditContainer> {
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_updateText);
  }

  void _updateText() {
    ref.read(originalWidgetViewProvider.notifier).updateStateCount();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('화면 새로고침 { Edit }');
    return Container(
      child: Row(
        children: [
          Icon(Icons.add),
          Expanded(
              child: TextField(
            controller: myController,
          )),
          ElevatedButton(
              onPressed: () {
                debugPrint('controller : ${myController.text}');
                ref
                    .read(originalWidgetViewProvider.notifier)
                    .updateState(text: myController.text);
                myController.text = '';
              },
              child: Text('전송'))
        ],
      ),
    );
  }
}
