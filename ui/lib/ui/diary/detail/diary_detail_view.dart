import 'package:flutter/material.dart';
import 'package:ui/test/log.dart';
import 'package:ui/ui/diary/data/diary_data.dart';
import 'package:ui/ui/diary/data/diary_model.dart';

class DiaryDetailView extends StatelessWidget {
  final int id;
  const DiaryDetailView({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일기 수정'),
        actions: [
          _DiaryDetailActionButton(
            child: Text('초기화', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Log.d('최초 원본 상태로 되돌리기');
            },
          ),
          _DiaryDetailActionButton(
            child: Text('삭제', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Log.d('삭제 후 화면닫고 삭제탭으로 이동해야함');
            },
          ),
          _DiaryDetailActionButton(
            child: Text('저장', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Log.d('저장 후 화면닫고 일기탭으로 이동해야함');
            },
          ),
        ],
      ),
      body: _Detail(id: id),
    );
  }
}

class _DiaryDetailActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const _DiaryDetailActionButton({
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
        overlayColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
      ),
      child: child,
    );
  }
}

class _Detail extends StatefulWidget {
  final int id;
  const _Detail({required this.id});

  @override
  State<_Detail> createState() => _DetailState();
}

class _DetailState extends State<_Detail> {
  late Color _color;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final DiaryModel item =
        allData.singleWhere((element) => element.id == widget.id);
    _color = item.color.getColor();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    final DiaryModel item =
        allData.singleWhere((element) => element.id == widget.id);
    Log.d('_Detail Build! 🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉 ');
    return Container(
      color: _color,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (index > 3) {
                    index = 0;
                  }
                  setState(() {
                    _color = DiaryColor.values[index++].getColor();
                  });
                },
                child: Text('랜덤 컬러 변경(빌드 갱신 테스트용)'),
              ),
              _DiaryColorWidget(
                value: item.color,
                func: (color) {
                  setState(() {
                    _color = color;
                  });
                },
              ),
              _ContentWidget(
                content: item.content,
              ),
              _SelectedStateWidget(
                selectedState: item.selectedState,
              ),
              _UsersWidget(
                selectedUsers: item.users,
              ),
              Flexible(
                child: _EtcWidget(
                  // gKey: formKey,
                  data: item.etc,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiaryColorWidget extends StatefulWidget {
  final DiaryColor value;
  final void Function(Color color)? func;
  const _DiaryColorWidget({required this.value, this.func});

  @override
  State<_DiaryColorWidget> createState() => _DiaryColorWidgetState();
}

class _DiaryColorWidgetState extends State<_DiaryColorWidget> {
  late DiaryColor _value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    Log.d('_DiaryColorWidget Build');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('배경색'),
        DropdownButton(
          value: _value,
          items: DiaryColor.values.map((e) {
            return DropdownMenuItem<DiaryColor>(value: e, child: Text(e.name));
          }).toList(),
          onChanged: (value) {
            Log.d('색상변경합니다. : $value');
            if (value != null) {
              setState(() {
                _value = value;
                widget.func?.call(value.getColor());
              });
            }
          },
        )
      ],
    );
  }
}

class _ContentWidget extends StatefulWidget {
  final String content;
  const _ContentWidget({
    required this.content,
  });

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.content;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Log.d('_ContentWidget Build');
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _textController,
      decoration: InputDecoration(
        hintText: '내용쓰세요.',
        helperText: '내용헬퍼텍스트',
        labelText: '일기내용',
        filled: true,
        fillColor: Colors.blue.shade100,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _SelectedStateWidget extends StatefulWidget {
  final bool selectedState;
  const _SelectedStateWidget({
    required this.selectedState,
  });

  @override
  State<_SelectedStateWidget> createState() => _SelectedStateWidgetState();
}

class _SelectedStateWidgetState extends State<_SelectedStateWidget> {
  bool _state = false;
  @override
  void initState() {
    super.initState();
    _state = widget.selectedState;
  }

  @override
  Widget build(BuildContext context) {
    Log.d('_SelectedStateWidget Build');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('일기 선택 상태'),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                title: Text('선택'),
                value: true,
                groupValue: _state,
                onChanged: (value) {
                  Log.d('사용자 선택 : $value');
                  if (value != null) {
                    setState(() {
                      _state = value;
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                title: Text('미선택'),
                value: false,
                groupValue: _state,
                onChanged: (value) {
                  Log.d('사용자 미선택 : $value');
                  if (value != null) {
                    setState(() {
                      _state = value;
                    });
                  }
                },
              ),
            )
          ],
        )
      ],
    );
  }
}

class _UsersWidget extends StatefulWidget {
  final List<DiaryUserModel> selectedUsers;
  const _UsersWidget({
    required this.selectedUsers,
  });

  @override
  State<_UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<_UsersWidget> {
  late List<DiaryUserModel> _stateList;

  @override
  void initState() {
    super.initState();
    _stateList = widget.selectedUsers;
  }

  @override
  Widget build(BuildContext context) {
    Log.d('_UsersWidget Build');
    final dataList = allUsers.values.toList();
    return Column(
      children: [
        Text('만난사람'),
        SingleChildScrollView(
          child: Row(
            children: dataList.map((e) {
              return Row(
                children: [
                  Checkbox(
                    value: widget.selectedUsers.contains(e),
                    onChanged: (value) {
                      Log.d('사용자클릭 : ${e.name}');
                      if (value != null) {
                        setState(() {
                          if (value) {
                            _stateList.add(e);
                          } else {
                            _stateList
                                .removeWhere((element) => element.id == e.id);
                          }
                        });
                      }
                    },
                  ),
                  Text(e.name),
                ],
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class _EtcOverTestWidget extends StatelessWidget {
  final List<DiaryEtcModel> data;
  const _EtcOverTestWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...data,
          ...data,
        ].map((e) {
          // Log.d('그립니다 !! : ${e.etc}');
          return Center(
            child: Text('${e.etc}'),
          );
        }).toList(),
      ),
    );
  }
}

/// 중요한건 formKey가 외부에 있어야합니다.
/// appbar 의 저장버튼 클릭시 formKey를 사용해야합니다.
class _Etc2Widget extends StatefulWidget {
  final List<DiaryEtcModel> data;
  final GlobalKey<FormState> gKey;

  _Etc2Widget({
    required this.gKey,
    required this.data,
  });

  @override
  State<_Etc2Widget> createState() => _Etc2WidgetState();
}

class _Etc2WidgetState extends State<_Etc2Widget> {
  late List<DiaryEtcModel> stateDataList;
  @override
  void initState() {
    super.initState();
    stateDataList = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    Log.d('_Etc2Widget Build');
    return Column(
      children: [
        Flexible(
          child: Form(
            key: widget.gKey,
            child: ListView.builder(
              itemCount: stateDataList.length,
              itemBuilder: (context, index) {
                final item = stateDataList[index];
                Log.d('Etc 2 Widgete List Item 생성 : ${index} / ${item.etc}');
                return _TitleTextField(
                  title: '기타 ${index + 1} : ',
                  initValue: item.etc,
                  onChanged: (newValue) {
                    Log.d('변경중인 내용 : $index / $newValue');
                  },
                  onSaved: (newValue) {
                    Log.d('입력된 내용 : $index / $newValue');
                  },
                  validator: (value) {
                    if (value.length == 0) {
                      return '내용입력덜되었음';
                    }
                    return null;
                  },
                  onPressed: () {
                    Log.d('기타 삭제 : $index');
                    setState(() {
                      stateDataList.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            assert(widget.gKey.currentState != null, '스테이트가 널');
            if (widget.gKey.currentState!.validate()) {
              Log.d('모든 ETC Validate 통과');
              widget.gKey.currentState!.save();
            }
          },
          child: Text('저장하기 테스트용'),
        ),
        _AddEtc(
          onAddEtcPressed: () {
            Log.d('새로운 Etc 추가해줘');
            setState(() {
              final newEtc = DiaryEtcModel.create();
              stateDataList.add(newEtc);
            });
          },
        ),
      ],
    );
  }
}

class _TitleTextField extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final FormFieldSetter onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator validator;
  final String initValue;
  const _TitleTextField({
    required this.title,
    this.onPressed,
    this.onChanged,
    required this.initValue,
    required this.onSaved,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        Expanded(
          child: TextFormField(
            controller: TextEditingController(text: initValue),
            autovalidateMode: AutovalidateMode.always,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}

class _EtcWidget extends StatefulWidget {
  final List<DiaryEtcModel> data;
  const _EtcWidget({required this.data});

  @override
  State<_EtcWidget> createState() => _EtcWidgetState();
}

class _EtcWidgetState extends State<_EtcWidget> {
  late List<DiaryEtcModel> stateDataList;
  final Map<int, TextEditingController> _TextControllers = {};

  @override
  void initState() {
    super.initState();
    stateDataList = widget.data;
    for (var entry in widget.data) {
      _TextControllers[entry.id] = _createTextEditController(
        entry.etc,
        () {
          assert(_TextControllers.containsKey(entry.id), "컨트롤러를 찾을 수 없음");
          Log.d(
              '텍스트 수정 / id = ${entry.id} / content = ${_TextControllers[entry.id]?.text}');
        },
      );
    }
  }

  TextEditingController _createTextEditController(
      String text, VoidCallback callback) {
    final _controller = TextEditingController(text: text);
    _controller.addListener(callback);
    return _controller;
  }

  @override
  Widget build(BuildContext context) {
    Log.d('_EtcWidget Build');
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: stateDataList.length,
            itemBuilder: (context, index) {
              final item = stateDataList[index];
              final controller = _TextControllers[item.id];
              Log.d('EtcWidgete List Item 생성 : ${index}');
              return Row(
                children: [
                  Text('기타 ${index + 1} '),
                  Expanded(
                    child: TextField(
                      controller: controller,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Log.d('기타 삭제 : $index');
                      setState(() {
                        stateDataList.removeAt(index);
                        _TextControllers.remove(item.id);
                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              );
            },
          ),
        ),
        _AddEtc(
          onAddEtcPressed: () {
            Log.d('새로운 Etc 추가해줘');
            setState(() {
              final newEtc = DiaryEtcModel.create();
              stateDataList.add(newEtc);
              _TextControllers[newEtc.id] = _createTextEditController(
                newEtc.etc,
                () {
                  assert(_TextControllers.containsKey(newEtc.id),
                      "컨트롤러를 찾을 수 없음(new)");
                  Log.d(
                      '텍스트 수정 / id = ${newEtc.id} / content = ${_TextControllers[newEtc.id]?.text}');
                },
              );
            });
          },
        ),
      ],
    );
  }
}

class _AddEtc extends StatelessWidget {
  final VoidCallback? onAddEtcPressed;
  const _AddEtc({required this.onAddEtcPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.plus_one),
        ElevatedButton(onPressed: onAddEtcPressed, child: Text('새로운 Etc 추가하기'))
      ],
    );
  }
}
