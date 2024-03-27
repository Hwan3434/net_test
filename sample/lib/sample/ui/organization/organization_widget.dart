import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/login/login_widget.dart';
import 'package:sample/sample/ui/organization/organization_model.dart';
import 'package:sample/sample/ui/organization/organization_notifier.dart';
import 'package:sample/sample/ui/state_test/state_test_widget.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_field.dart';

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
              ref
                  .read(GlobalStateStorage().loginOrganizationProvider.notifier)
                  .update((state) => 'oooggg');
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return StateTestWidget();
                },
              ));
              // final org = controller.text;
              // if (org.isNotEmpty) {
              //   ref
              //       .read(
              //           GlobalStateStorage().loginOrganizationProvider.notifier)
              //       .update((state) => controller.text);
              // }
            },
            child: Text('다음'),
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
