import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/appbar/oc_appbar_component_model.dart';
import 'package:net_test/common/appbar/oc_appbar_component_provider.dart';
import 'package:net_test/common/base/base_state_view.dart';

/// Appbar는 preferredSize로 직접 height를 강제 합니다.
/// 이때 Orientation은 width height의 비율에따라 portrait, landscape로 판단합니다.
/// appbar는 그래서 항상 landscape로 판단됩니다.
class OcAppbarComponent extends BaseStateView<OcAppbarComponentModel>
    implements PreferredSizeWidget {
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  @override
  ProviderListenable<OcAppbarComponentModel> get viewProvider =>
      ocAppbarComponentProvider;

  OcAppbarComponent({
    super.key,
    this.systemUiOverlayStyle,
  });

  @override
  void initializeWidgetMap(WidgetRef ref) {
    buildAll(
      'OcAppbarComponentModel',
      portraitFunc: (p0) {
        return AppBar(
          title: Text(p0.name),
          systemOverlayStyle: systemUiOverlayStyle,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
