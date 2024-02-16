// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// typedef CreateFunc<NotifierT extends StateNotifier> = NotifierT Function(
//     Ref ref);
//
// AutoDisposeStateNotifierProvider<NotifierT, VM>
//     createViewProvider<NotifierT extends StateNotifier<VM>, VM>(
//   CreateFunc<NotifierT> create,
// ) {
//   return StateNotifierProvider.autoDispose<NotifierT, VM>(
//     (ref) {
//       return create.call(ref);
//     },
//   );
// }
