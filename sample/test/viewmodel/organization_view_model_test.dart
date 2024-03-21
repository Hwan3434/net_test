import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/organization/organization_model.dart';
import 'package:sample/sample/ui/organization/organization_notifier.dart';

import 'test_util.dart';

final organizationTestProvider =
    StateNotifierProvider.autoDispose<OrganizationNotifier, OrganizationModel>(
        (ref) {
  final org = ref.read(GlobalStateStorage().loginOrganizationProvider);
  return OrganizationNotifier(OrganizationModel(org: org));
});

void main() {
  group('조직 뷰 모델 테스트', () {
    test('조직 뷰 모델 초기화 상태 파악', () {
      final lis = Listener<OrganizationModel>();
      final container = createContainer(organizationTestProvider, lis);

      expect(container.read(organizationTestProvider).org, '');
    });

    test('조직 뷰 모델 컨트롤', () {
      final lis = Listener<OrganizationModel>();
      final container = createContainer(organizationTestProvider, lis);

      container.listen(GlobalStateStorage().loginOrganizationProvider,
          (previous, next) {
        container.read(organizationTestProvider.notifier).update(next);
      });

      expect(container.read(organizationTestProvider).org, '');
      container.read(organizationTestProvider.notifier).update('org');
      expect(container.read(organizationTestProvider).org, 'org');

      container
          .read(GlobalStateStorage().loginOrganizationProvider.notifier)
          .update((state) => 'org_global');

      expect(container.read(organizationTestProvider).org, 'org_global');
    });
  });
}
