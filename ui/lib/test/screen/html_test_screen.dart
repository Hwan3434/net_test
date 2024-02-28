// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
//
// class HtmlTest extends StatelessWidget {
//   const HtmlTest({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final contents =
//         '''<p>wefq</p>\n<ol>\n<li>wefwef</li>\n<li>wefwef</li>\n<li>wefwef</li>\n<li>wefwef\n<ol>\n<li>efwefwef</li>\n<li>wefwef\n<ol>\n<li>wefwef</li>\n<li>wefwef\n<ol>\n<li>wefqweqwe</li>\n<li>qwr</li>\n</ol>\n</li>\n</ol>\n</li>\n<li>werwer</li>\n<li>wefwef</li>\n</ol>\n</li>\n<li>qwrqweqw</li>\n<li>qweqwe</li>\n</ol>\n<ul style=\"list-style-type: square;\">\n<li>qwrqweqwe\n<ul style=\"list-style-type: square;\">\n<li>qqweqwfqwf</li>\n<li>wqeqweqwfq\n<ul style=\"list-style-type: square;\">\n<li>qweqeqweqwd</li>\n<li>qweqwe</li>\n<li>qweqwer</li>\n</ul>\n</li>\n<li>fwdwqwd</li>\n<li>qwrqweqwe</li>\n<li>qfqwfw\n<ul style=\"list-style-type: square;\">\n<li>qweqw</li>\n<li>rqwe\n<ul style=\"list-style-type: square;\">\n<li>qweqwr\n<ul style=\"list-style-type: square;\">\n<li>qweqwfq\n<ul style=\"list-style-type: square;\">\n<li>qweqwe\n<ul style=\"list-style-type: square;\">\n<li>qweqfqw\n<ul style=\"list-style-type: square;\">\n<li>qweqwd\n<ul style=\"list-style-type: square;\">\n<li>qweqwd\n<ul style=\"list-style-type: square;\">\n<li>qweqwd\n<ul style=\"list-style-type: square;\">\n<li>qwdq\n<ul style=\"list-style-type: square;\">\n<li>qwfqw\n<ul style=\"list-style-type: square;\">\n<li>wfqwfqwdq\n<ul style=\"list-style-type: square;\">\n<li>qfqwf\n<ul style=\"list-style-type: square;\">\n<li>wqwfqwfqwfdqwd\n<ul style=\"list-style-type: square;\">\n<li>qwfqwf\n<ul style=\"list-style-type: square;\">\n<li>qwfqwf\n<ul style=\"list-style-type: square;\">\n<li>wqfqwf\n<ul style=\"list-style-type: square;\">\n<li>qwfqwf\n<ul style=\"list-style-type: square;\">\n<li>qwfqwdqwd\n<ul style=\"list-style-type: square;\">\n<li>qwfqwfd\n<ul style=\"list-style-type: square;\">\n<li>qwgqwfqw\n<ul style=\"list-style-type: square;\">\n<li>qwgqwdq\n<ul style=\"list-style-type: square;\">\n<li>qgqwdfqw\n<ul style=\"list-style-type: square;\">\n<li>qwgqwd\n<ul style=\"list-style-type: square;\">\n<li>qgqwdqwd\n<ul style=\"list-style-type: square;\">\n<li>qgwqdqwd\n<ul style=\"list-style-type: square;\">\n<li>gwqd</li>\n</ul>\n</li>\n<li>qweqwf</li>\n<li>qwfqw\n<ul>\n<li style=\"list-style-type: none;\">\n<ul style=\"list-style-type: square;\">\n<li>qwdqwfqw</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n<li>qwfqwf</li>\n<li>qwfqwf</li>\n<li>qwfqwfqwf\n<ul>\n<li style=\"list-style-type: none;\">\n<ul style=\"list-style-type: square;\">\n<li>qwqfqwf</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n<li>qwfqwf</li>\n</ul>\n</li>\n<li>qwf</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n</li>\n<li>qwf</li>\n<li>qwf</li>\n</ul>\n</li>\n</ul>\n</li>\n<li>qwfqwf</li>\n</ul>\n</li>\n</ul>\n</li>\n<li>qwf</li>\n</ul>\n</li>\n</ul>\n</li>\n<li>qwf</li>\n<li>qwdqwd</li>\n</ul>\n</li>\n<li>qwdqwd</li>\n</ul>\n</li>\n<li>qwfqw</li>\n</ul>\n</li>\n</ul>\n</li>\n</ul>\n<p>qwdqwd</p>\n<p>&nbsp;</p>\n<p>fqwf</p>\n<p>qwf</p>''';
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: HtmlWidget(contents),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
