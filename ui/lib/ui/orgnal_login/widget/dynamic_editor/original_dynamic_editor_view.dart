import 'package:data/common/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/widget/dynamic_editor/dynamic_editor_view_provider.dart';

class OriginalDynamicEditorView extends ConsumerStatefulWidget {
  const OriginalDynamicEditorView({super.key});

  @override
  ConsumerState<OriginalDynamicEditorView> createState() =>
      _OriginalDynamicEditorViewState();
}

class _OriginalDynamicEditorViewState
    extends ConsumerState<OriginalDynamicEditorView> {
  final List<TextEditingController> controllers = [];

  @override
  Widget build(BuildContext context) {
    final dynamicEditorViewModel = ref.read(dynamicEditorViewProvider);
    Log.e('Scaffold build !!');
    for (var element in dynamicEditorViewModel.data) {
      final controller = TextEditingController(text: element.editorString);
      controllers.add(controller);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('DynamicEditor'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref.invalidate(dynamicEditorViewProvider);
                  for (int i = 0; i < dynamicEditorViewModel.data.length; i++) {
                    controllers[i].text =
                        dynamicEditorViewModel.data[i].editorString;
                  }
                },
                icon: Icon(Icons.refresh),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  for (var element in controllers) {
                    element.clear();
                  }
                  ref.read(dynamicEditorViewProvider.notifier).clear();
                },
                icon: Icon(Icons.restore_from_trash),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  final sendData = ref.read(dynamicEditorViewProvider);
                  for (var element in sendData.data) {
                    Log.e(
                        '${element.name} : element value : ${element.editorString}');
                  }
                },
                icon: Icon(Icons.send),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: _DynamicWidget(
          data: dynamicEditorViewModel.data,
          controllers: controllers,
        ),
      ),
    );
  }
}

class _DynamicWidget extends StatelessWidget {
  final List<DynamicEditorDataModel> data;
  final List<TextEditingController> controllers;
  const _DynamicWidget({
    required this.data,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _DynamicEditorWidget(
          model: data[index],
          controller: controllers[index],
        );
      },
    );
  }
}

class _DynamicEditorWidget extends StatelessWidget {
  final DynamicEditorDataModel model;
  final TextEditingController controller;
  const _DynamicEditorWidget({
    required this.model,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Log.e('빌드 갱신 1');
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Text(model.name),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              Log.e('빌드 갱신 2');
              return Column(
                children: [
                  TextField(
                    controller: controller,
                    onChanged: (value) {
                      Log.e('${model.name} : Editor onChanged : $value');
                      ref
                          .read(dynamicEditorViewProvider.notifier)
                          .update(model.id, value);
                    },
                  ),
                  Consumer(builder: (context, ref, child) {
                    Log.e('${model.name} - 빌드 갱신 3');
                    final String text = ref.watch(
                      dynamicEditorViewProvider.select(
                        (value) {
                          return value.data.singleWhere((element) {
                            return element.id == model.id;
                          }).editorString;
                        },
                      ),
                    );

                    /// todo 비효울 갱신
                    // final data = ref.watch(
                    //   dynamicEditorViewProvider.select(
                    //     (value) {
                    //       return value.data;
                    //     },
                    //   ),
                    // );
                    // final text = data.singleWhere((element) {
                    //   return element.id == model.id;
                    // }).editorString;
                    return Text('밸리데이트 체크 : ${text}');
                  }),
                ],
              );
            }),
          ),
          Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                ref
                    .read(dynamicEditorViewProvider.notifier)
                    .update(model.id, '');
                controller.clear();
              },
              icon: Icon(
                Icons.restore_from_trash_rounded,
              ),
            );
          })
        ],
      ),
    );
  }
}
