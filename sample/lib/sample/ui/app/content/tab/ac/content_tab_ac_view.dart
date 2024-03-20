import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/framework.dart';
import 'package:sample/sample/ui/app/content/content_notifier.dart';
import 'package:sample/sample/ui/app/content/content_view.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class ContentTabAcView
    extends ProviderStatelessWidget<ContentNotifier, ContentViewModel> {
  const ContentTabAcView();

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    return Center(child: BTextWidget('ACWidget'));
  }

  @override
  ProviderBase<ContentViewModel> get provider =>
      ContentView.contentViewModelProvider;
}
