import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/shared/shared_data_manager.dart';
import 'package:sample/sample/ui/app/content/content_view_model.dart';
import 'package:sample/sample/ui/app/content/content_widget.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';

class ContentTabAbcWidget
    extends ProviderStatefulWidget<ContentViewModelNotifier, ContentViewModel> {
  const ContentTabAbcWidget();

  @override
  ProviderState createState() => _ContentTabAbcBodyWidgetState();

  @override
  ProviderBase<ContentViewModel> get provider =>
      ContentWidget.contentViewModelProvider;
}

class _ContentTabAbcBodyWidgetState extends ProviderState<ContentTabAbcWidget,
    ContentViewModelNotifier, ContentViewModel> {
  @override
  Widget pBuild(BuildContext context) {
    Log.i("ContentTabAbcWidget Build");
    return Center(
      child: BButton(
        onPressed: () {
          ref.read(GlobalStateStorage().agentStateProvider.notifier).logout();
          GlobalStateStorage().clear(ref);
          SharedDataManger().clear();
        },
        child: Text('로그아웃'),
      ),
    );
  }
}
