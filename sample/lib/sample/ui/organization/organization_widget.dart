import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/login/login_widget.dart';
import 'package:sample/sample/ui/organization/organization_model.dart';
import 'package:sample/sample/ui/organization/organization_notifier.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_field.dart';
import 'package:sample/sample/widget/dialog/dialog_organization_body.dart';

class OrganizationWidget
    extends ProviderStatefulWidget<OrganizationNotifier, OrganizationModel> {
  static String get path => '/Organization';
  static String get name => 'OrganizationWidget';

  const OrganizationWidget({super.key});

  @override
  ProviderState<OrganizationWidget, OrganizationNotifier, OrganizationModel>
      createState() => _MyAppState();

  @override
  AutoDisposeStateNotifierProvider<OrganizationNotifier, OrganizationModel>
      get provider => organizationProvider;

  static final organizationProvider = StateNotifierProvider.autoDispose<
      OrganizationNotifier, OrganizationModel>((ref) {
    final org = ref.read(GlobalStateStorage().loginOrganizationProvider);
    return OrganizationNotifier(OrganizationModel(org: org));
  });
}

class _MyAppState extends ProviderState<OrganizationWidget,
    OrganizationNotifier, OrganizationModel> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget pBuild(BuildContext context) {
    ref.listen(GlobalStateStorage().loginOrganizationProvider,
        (previous, next) {
      if (next.isNotEmpty) {
        ref.read(widget.provider.notifier).update(next);
      }
    });

    ref.listen(widget.provider, (previous, next) {
      if (next.org.isNotEmpty) {
        context.goNamed(LoginWidget.name);
      }
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BTextField(
            controller: controller,
          ),
          BButton(
            onPressed: () {
              final org = controller.text;
              if (org.isNotEmpty) {
                ref
                    .read(
                        GlobalStateStorage().loginOrganizationProvider.notifier)
                    .update((state) => controller.text);
              }
            },
            child: Text('다음'),
          ),
          BButton(
            onPressed: () {
              final org = controller.text;
              if (org.isEmpty) {
                return;
              }
              showDialog(
                context: context,
                barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                builder: ((context) {
                  return AlertDialog(
                    title: Text("조직 로그인"),
                    content: DialogOrganizationBody(
                      organization: controller.text,
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          if (org.isNotEmpty) {
                            ref
                                .read(GlobalStateStorage()
                                    .loginOrganizationProvider
                                    .notifier)
                                .update((state) => controller.text);
                          }
                          context.pop();
                        },
                        child: Text("네"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text("아니요"),
                      ),
                    ],
                  );
                }),
              );
            },
            child: Text('팝업'),
          )
        ],
      ),
    );
  }
}

// class _TempTopWidget extends StatelessWidget {
//   const _TempTopWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BTextField(
//       controller: controller,
//     );
//   }
// }
//
// class _TempBottomWidget extends StatelessWidget {
//   const _TempBottomWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BButton(
//       onPressed: () {
//         final org = controller.text;
//         if (org.isNotEmpty) {
//           ref
//               .read(
//               GlobalStateStorage().loginOrganizationProvider.notifier)
//               .update((state) => controller.text);
//         }
//       },
//       child: Text('다음'),
//     );
//   }
// }
