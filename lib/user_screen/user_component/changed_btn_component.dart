// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:net_test/user_screen/user_view/user_view.dart';
//
// class ChangedBtnComponent extends ConsumerWidget {
//   final VoidCallback? onPressed;
//
//   const ChangedBtnComponent({super.key, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: UserPageViews.values.map((e) {
//           return Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: SampleButton(screen: e, onPressed: onPressed),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class SampleButton extends StatelessWidget {
//   final UserPageViews screen;
//   final VoidCallback? onPressed;
//
//   const SampleButton(
//       {super.key, required this.screen, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         return ElevatedButton(
//           onPressed: onPressed,
//           child: Text(
//             screen.toString(),
//           ),
//         );
//       },
//     );
//   }
// }
