import 'package:data/common/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/widget/editor/editor_view_provider.dart';

class OriginalEditorView extends StatefulWidget {
  const OriginalEditorView({super.key});

  @override
  State<OriginalEditorView> createState() => _OriginalEditorViewState();
}

class _OriginalEditorViewState extends State<OriginalEditorView> {
  final TextEditingController headerController = TextEditingController();
  final TextEditingController midController = TextEditingController();
  final TextEditingController bottomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editor'),
        actions: [
          Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                headerController.clear();
                midController.clear();
                bottomController.clear();
                ref.read(editorViewProvider.notifier).clear();
              },
              icon: Icon(Icons.restore_from_trash_rounded),
            );
          }),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref
                      .read(editorViewProvider.notifier)
                      .update(mid: midController.text);

                  final editorData = ref.read(editorViewProvider);
                  Log.e('header : ${editorData.header}');
                  Log.e('mid : ${editorData.mid}');
                  Log.e('bottom : ${editorData.bottom}');
                },
                icon: Icon(Icons.send),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _EditorListWidget(
            headerController: headerController,
            midController: midController,
            bottomController: bottomController,
          ),
        ),
      ),
    );
  }
}

class _EditorListWidget extends StatelessWidget {
  final TextEditingController headerController;
  final TextEditingController midController;
  final TextEditingController bottomController;
  const _EditorListWidget({
    required this.headerController,
    required this.midController,
    required this.bottomController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('이건 입력과 동시에 저장')),
              Expanded(
                child: Consumer(builder: (context, ref, child) {
                  Log.e('header Editor refresh');
                  return TextField(
                    controller: headerController,
                    onChanged: (value) {
                      Log.e('변경 파악! header : $value');
                      ref
                          .read(editorViewProvider.notifier)
                          .update(header: value);
                    },
                  );
                }),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('이건 Send버튼 클릭시 저장')),
              Expanded(
                child: Consumer(builder: (context, ref, child) {
                  Log.e('mid Editor refresh');
                  return TextField(
                    controller: midController,
                    onChanged: (value) {
                      Log.e('변경 파악! mid : $value');
                    },
                  );
                }),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('텍스트 박스 여러줄\n(초기값있음)\n실시간저장ㄷ')),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    Log.e('bottom Editor refresh');
                    final bot = ref.watch(
                        editorViewProvider.select((value) => value.bottom));
                    bottomController.text = bot;
                    return TextField(
                      controller: bottomController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (value) {
                        Log.e('변경 파악! : $value');
                        ref
                            .read(editorViewProvider.notifier)
                            .update(bottom: value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
