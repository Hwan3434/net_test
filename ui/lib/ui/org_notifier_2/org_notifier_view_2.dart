import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'org_notifier_view_model_2.dart';
import 'org_notifier_view_provider_2.dart';

class OrgNotifierView2 extends ConsumerStatefulWidget {
  const OrgNotifierView2({
    super.key,
  });

  @override
  ConsumerState<OrgNotifierView2> createState() => _OrgNotifierViewState2();
}

class _OrgNotifierViewState2 extends ConsumerState<OrgNotifierView2> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orgNotifierViewProvider2);

    switch (state.state) {
      case OrgNotifierViewState.wait:
        return Center(
          child: ElevatedButton(
              onPressed: () {
                ref.read(orgNotifierViewProvider2.notifier).callUsers();
              },
              child: Text('사용자 가져오기(Wait)')),
        );
      case OrgNotifierViewState.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case OrgNotifierViewState.success:
        final length = state.data.length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(orgNotifierViewProvider2.notifier).callUsers();
                },
                child: Text('새로불러오기'),
              ),
              Text('등록된 사용자 : $length명'),
              Expanded(
                child: ListView.builder(
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final item = state.data.elementAt(index);
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
                                    .read(orgNotifierViewProvider2.notifier)
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
      case OrgNotifierViewState.error:
        return Center(
          child: Text("error"),
        );
    }
  }
}
