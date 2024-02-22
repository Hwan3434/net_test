import 'package:flutter/material.dart';
import 'package:ui/ui/change_cls/cls_view.dart';
import 'package:ui/ui/change_first/first_view.dart';
import 'package:ui/ui/change_last/last_view.dart';
import 'package:ui/ui/change_wapper/wrapper_view.dart';
import 'package:ui/ui/diary/diary_view.dart';
import 'package:ui/ui/org_notifier/org_notifier_view.dart';
import 'package:ui/ui/org_notifier_2/org_notifier_view_2.dart';
import 'package:ui/ui/orgnal_login/widget/original_login_view.dart';
import 'package:ui/ui/original/original_view.dart';
import 'package:ui/ui/original_widget/original_widget_view.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestApp'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OrgLoginWidget();
                    },
                  ),
                );
              },
              child: Text(
                'Org Login',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DiaryView();
                    },
                  ),
                );
              },
              child: Text(
                'Diary',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(body: WraaperOriginWidget());
                    },
                  ),
                );
              },
              child: Text(
                'Original',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(body: OriginalWidgetView());
                    },
                  ),
                );
              },
              child: Text(
                'Original_widget',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(
                        body: SafeArea(child: OrgNotifierView()),
                      );
                    },
                  ),
                );
              },
              child: Text(
                'Org_Notifier',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(
                        body: SafeArea(child: OrgNotifierView2()),
                      );
                    },
                  ),
                );
              },
              child: Text(
                'Org_Notifier 2',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(body: FirstView());
                    },
                  ),
                );
              },
              child: Text(
                'FirstView',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(body: ClsView());
                    },
                  ),
                );
              },
              child: Text(
                'cls',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(body: WrapperView());
                    },
                  ),
                );
              },
              child: Text(
                'provider',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(body: LastView());
                    },
                  ),
                );
              },
              child: Text(
                'Last',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
