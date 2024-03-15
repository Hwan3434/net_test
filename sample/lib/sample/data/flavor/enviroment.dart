import 'package:flutter/material.dart';
import 'package:sample/sample/data/common/const.dart';
import 'package:sample/sample/data/flavor/widget/alpha_widget.dart';
import 'package:sample/sample/data/flavor/widget/prod_widget.dart';
import 'package:sample/sample/data/flavor/widget/test_widget.dart';

sealed class Environment {
  final String mode;
  final String url;
  Environment({
    required this.mode,
    required this.url,
  });

  factory Environment.alpha() => _AlphaEnv();
  factory Environment.test() => _TestEnv();
  factory Environment.prod() => ProdEnv();

  Widget create(Widget child);
}

class _AlphaEnv extends Environment {
  _AlphaEnv()
      : super(
          mode: Const.alphaMode,
          url: Const.alphaUrl,
        );

  @override
  Widget create(Widget child) {
    return AlphaWidget(child: child);
  }
}

class _TestEnv extends Environment {
  _TestEnv()
      : super(
          mode: Const.testMode,
          url: Const.testUrl,
        );

  @override
  Widget create(Widget child) {
    return TestWidget(child: child);
  }
}

class ProdEnv extends Environment {
  ProdEnv()
      : super(
          mode: Const.prodMode,
          url: Const.prodUrl,
        );

  @override
  Widget create(Widget child) {
    return ProdWidget(child: child);
  }
}
