import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/agent/model/agent_state_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/app/common/user_detail_view.dart';
import 'package:sample/sample/ui/app/content/content_view.dart';
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
      if (next.state == AgentState.logout) {
        notifyListeners();
      }
    });
  }

  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    final agent = ref.read(GlobalStateStorage().agentStateProvider);
    if (agent.state == AgentState.logout) {
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
      path: ContentView.path,
      name: ContentView.name,
      pageBuilder: (context, state) {
        return const MaterialPage(child: ContentView());
      },
      routes: [
        GoRoute(
          path: UserDetailView.path,
          name: UserDetailView.name,
          pageBuilder: (context, state) {
            final userId = state.extra;
            assert(userId is int);
            return MaterialPage(
                child: UserDetailView(
              userId: userId as int,
            ));
          },
        ),
      ],
    ),
  ];
}
