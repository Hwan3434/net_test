import 'package:flutter/material.dart';
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
          IconButton(
              onPressed: () {
                debugPrint('삭제 후 화면닫고 삭제탭으로 이동해야함');
              },
              icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                debugPrint('저장 후 화면닫고 일기탭으로 이동해야함');
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: SafeArea(child: _Detail(id: id)),
    );
  }
}

class _Detail extends StatelessWidget {
  final int id;
  const _Detail({required this.id});

  @override
  Widget build(BuildContext context) {
    final DiaryModel item = allData.singleWhere((element) => element.id == id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _DiaryColorWidget(
            value: item.color,
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
              data: item.etc,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiaryColorWidget extends StatefulWidget {
  final DiaryColor value;
  const _DiaryColorWidget({required this.value});

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
    return Column(
      children: [
        Text('배경색'),
        DropdownButton(
          value: _value,
          items: DiaryColor.values.map((e) {
            return DropdownMenuItem<DiaryColor>(value: e, child: Text(e.name));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _value = value;
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
    // TODO: implement initState
    super.initState();
    _textController.text = widget.content;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _textController,
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
    // TODO: implement initState
    super.initState();
    _state = widget.selectedState;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  debugPrint('사용자 선택 : $value');
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
                  debugPrint('사용자 미선택 : $value');
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
    // TODO: implement initState
    super.initState();
    _stateList = widget.selectedUsers;
  }

  @override
  Widget build(BuildContext context) {
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
                      debugPrint('사용자클릭 : ${e.name}');
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

class _EtcWidget extends StatefulWidget {
  final List<DiaryEtcModel> data;
  const _EtcWidget({required this.data});

  @override
  State<_EtcWidget> createState() => _EtcWidgetState();
}

class _EtcWidgetState extends State<_EtcWidget> {
  late List<DiaryEtcModel> stateDataList;
  Map<int, TextEditingController> _TextControllers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateDataList = widget.data;
    for (var entry in widget.data) {
      _TextControllers[entry.id] = TextEditingController(text: entry.etc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: stateDataList.length,
            itemBuilder: (context, index) {
              final item = stateDataList[index];
              final controller = _TextControllers[item.id];
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
                      debugPrint('기타 삭제 : $index');
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
            debugPrint('새로운 Etc 추가해줘');
            setState(() {
              final newEtc = DiaryEtcModel.create();
              stateDataList.add(newEtc);
              _TextControllers[newEtc.id] =
                  TextEditingController(text: newEtc.etc);
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
