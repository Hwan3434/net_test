import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/login/login_widget.dart';
import 'package:sample/sample/ui/organization/organization_model.dart';
import 'package:sample/sample/ui/organization/organization_notifier.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';

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
          TextField(
            controller: controller,
          ),
          ElevatedButton(
              onPressed: () {
                final org = controller.text;
                if (org.isNotEmpty) {
                  ref
                      .read(GlobalStateStorage()
                          .loginOrganizationProvider
                          .notifier)
                      .update((state) => controller.text);
                }
              },
              child: Text('다음'))
        ],
      ),
    );
  }
}
