import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/ui/app/common/test_sample_widget.dart';
import 'package:sample/sample/ui/app/common/user_detail.dart';
import 'package:sample/sample/ui/app/content/content_widget.dart';
import 'package:sample/sample/ui/common/loading_widget.dart';
import 'package:sample/sample/ui/login/login_widget.dart';
import 'package:sample/sample/ui/organization/organization_widget.dart';
import 'package:sample/sample/ui/splash/splash_widget.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _DomainStateNotifier(ref: ref);
  return GoRouter(
    initialLocation: SplashWidget.path,
    errorBuilder: (context, state) {
      return ErrorWidget('Router Error');
    },
    refreshListenable: refresh,
    redirect: refresh._redirect,
    routes: refresh._routes,
  );
});

class _DomainStateNotifier extends ChangeNotifier {
  final Ref ref;

  _DomainStateNotifier({
    required this.ref,
  }) {
    ref.listen(GlobalStateStorage().agentStateProvider, (previous, next) {
      if (next.state == AgentState.init) {
        notifyListeners();
      }
    });
  }

  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    final agent = ref.read(GlobalStateStorage().agentStateProvider);
    if (agent.state == AgentState.init) {
      return SplashWidget.path;
    }
    return null;
  }

  final List<GoRoute> _routes = [
    GoRoute(
      path: SplashWidget.path,
      name: SplashWidget.name,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SplashWidget());
      },
    ),
    GoRoute(
      path: OrganizationWidget.path,
      name: OrganizationWidget.name,
      pageBuilder: (context, state) {
        return const MaterialPage(child: OrganizationWidget());
      },
      routes: [
        GoRoute(
          path: LoginWidget.path,
          name: LoginWidget.name,
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginWidget());
          },
        ),
      ],
    ),
    GoRoute(
      path: LoginLoadingWidget.path,
      name: LoginLoadingWidget.name,
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginLoadingWidget());
      },
    ),
    GoRoute(
        path: ContentWidget.path,
        name: ContentWidget.name,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ContentWidget());
        },
        routes: [
          GoRoute(
            path: UserDetail.path,
            name: UserDetail.name,
            pageBuilder: (context, state) {
              final ProjectDataModel project = (state.extra as List)[0];
              final UserModel userModel = (state.extra as List)[1];
              return MaterialPage(
                  child: UserDetail(
                project: project,
                userModel: userModel,
              ));
            },
          ),
          GoRoute(
            path: TestSampleWidget.path,
            name: TestSampleWidget.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: TestSampleWidget(
                ts: state.params['ts']!,
              ));
            },
          ),
        ]),
  ];
}
