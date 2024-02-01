import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class InjeOrientationScreen extends ConsumerStatefulWidget {
  const InjeOrientationScreen({
    super.key,
  });

  @protected
  PreferredSizeWidget? appbar(BuildContext context, WidgetRef ref) => null;

  @protected
  Widget? floatingActionButton(BuildContext context, WidgetRef ref) => null;

  @protected
  Widget? bottomNavigationBar(BuildContext context, WidgetRef ref) => null;

  @protected
  bool get safeTop => true;

  @protected
  bool get safeBottom => true;

  @protected
  bool get safeRight => true;

  @protected
  bool get safeLeft => true;

  Widget buildPortrait(
    BuildContext context,
    WidgetRef ref,
  );

  Widget buildLandscape(
    BuildContext context,
    WidgetRef ref,
  );

  @override
  _InjeOrientationStateScreenState createState() =>
      _InjeOrientationStateScreenState();
}

class _InjeOrientationStateScreenState
    extends ConsumerState<InjeOrientationScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        appBar: widget.appbar(context, ref),
        body: SafeArea(
            right: widget.safeRight,
            top: widget.safeTop,
            bottom: widget.safeBottom,
            left: widget.safeLeft,
            child: switch (orientation) {
              Orientation.portrait => widget.buildPortrait(context, ref),
              Orientation.landscape => widget.buildPortrait(context, ref),
            }),
        floatingActionButton: widget.floatingActionButton(context, ref),
        bottomNavigationBar: widget.bottomNavigationBar(context, ref),
      );
    });
  }
}
