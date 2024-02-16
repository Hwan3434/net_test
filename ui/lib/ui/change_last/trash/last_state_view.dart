// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// abstract class LastStatefulView<NotifierT extends StateNotifier<VM>, VM>
//     extends ConsumerStatefulWidget {
//   const LastStatefulView({super.key});
//
//   AutoDisposeStateNotifierProvider<NotifierT, VM> get notifierProvider;
//   ProviderListenable<VM> get watchProvider;
//
//   @override
//   LastState createState();
// }
//
// abstract class LastState<T extends LastStatefulView<NotifierT, VM>,
//     NotifierT extends StateNotifier<VM>, VM> extends ConsumerState<T> {
//   Widget fulBuild(BuildContext context, VM viewModel);
//
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = ref.watch(widget.watchProvider);
//     return fulBuild(context, viewModel);
//   }
// }
//
// ///
// ///
// ///
//
// abstract class LastStateView<NotifierT extends StateNotifier<VM>, VM>
//     extends LastStatefulView<NotifierT, VM> {
//   const LastStateView({super.key});
//   Widget build(BuildContext context, WidgetRef ref, VM viewModel);
//
//   @override
//   _LastStateState createState() => _LastStateState();
// }
//
// class _LastStateState<
//     T extends LastStatefulView<NotifierT, VM>,
//     NotifierT extends StateNotifier<VM>,
//     VM> extends LastState<LastStateView<NotifierT, VM>, NotifierT, VM> {
//   @override
//   Widget fulBuild(BuildContext context, VM viewModel) {
//     return widget.build(context, ref, viewModel);
//   }
// }
