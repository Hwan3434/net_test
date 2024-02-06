import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'org_notifier_view_model.dart';
import 'org_notifier_view_provider.dart';

class OrgNotifierView extends ConsumerStatefulWidget {
  const OrgNotifierView({
    super.key,
  });

  @override
  ConsumerState<OrgNotifierView> createState() => _OrgNotifierViewState();
}

class _OrgNotifierViewState extends ConsumerState<OrgNotifierView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orgNotifierViewProvider);

    switch (state) {
      case OrgNotifierStateModelWait():
        return Center(
          child: ElevatedButton(
              onPressed: () {
                ref.read(orgNotifierViewProvider.notifier).callUsers();
              },
              child: Text('사용자 가져오기(Wait)')),
        );
      case OrgNotifierStateModelLoading():
        return Center(
          child: CircularProgressIndicator(),
        );
      case OrgNotifierStateModelSuccess(data: final data):
        final length = data.length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(orgNotifierViewProvider.notifier).callUsers();
                },
                child: Text('새로불러오기'),
              ),
              Text('등록된 사용자 : $length명'),
              Expanded(
                child: ListView.builder(
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final item = data.elementAt(index);
                    return Card(
                      key: UniqueKey(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item.name}(${item.id})'),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(orgNotifierViewProvider.notifier)
                                    .delete(item.id);
                              },
                              child: Text('삭제'),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      case OrgNotifierStateModelError():
        return Center(
          child: Text("error"),
        );
    }
  }
}
