// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// abstract class LastScreen extends ConsumerStatefulWidget {
//   const LastScreen({
//     super.key,
//   });
//
//   @protected
//   PreferredSizeWidget? appbar(BuildContext context, WidgetRef ref) => null;
//
//   @protected
//   Widget? floatingActionButton(BuildContext context, WidgetRef ref) => null;
//
//   @protected
//   Widget? bottomNavigationBar(BuildContext context, WidgetRef ref) => null;
//
//   @protected
//   bool get safeTop => true;
//
//   @protected
//   bool get safeBottom => true;
//
//   @protected
//   bool get safeRight => true;
//
//   @protected
//   bool get safeLeft => true;
//
//   Widget build(
//     BuildContext context,
//     WidgetRef ref,
//   );
//
//   @override
//   _InjeScreenState createState() => _InjeScreenState();
// }
//
// class _InjeScreenState extends ConsumerState<LastScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: widget.appbar(context, ref),
//       body: SafeArea(
//         right: widget.safeRight,
//         top: widget.safeTop,
//         bottom: widget.safeBottom,
//         left: widget.safeLeft,
//         child: widget.build(context, ref),
//       ),
//       floatingActionButton: widget.floatingActionButton(context, ref),
//       bottomNavigationBar: widget.bottomNavigationBar(context, ref),
//     );
//   }
// }
