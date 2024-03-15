import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
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
      builder: (context, state) {
        return SplashWidget(
          nextWidgetName: OrganizationWidget.name,
        );
      },
    ),
    GoRoute(
      path: OrganizationWidget.path,
      name: OrganizationWidget.name,
      builder: (context, state) {
        return OrganizationWidget();
      },
      routes: [
        GoRoute(
          path: LoginWidget.path,
          name: LoginWidget.name,
          builder: (context, state) {
            return LoginWidget();
          },
        ),
      ],
    ),
    GoRoute(
      path: LoginLoadingWidget.path,
      name: LoginLoadingWidget.name,
      builder: (context, state) {
        return LoginLoadingWidget(
          callback: (state) {
            if (state == AgentState.wait) {
              context.goNamed(SplashWidget.name);
            }
            if (state == AgentState.success) {
              context.goNamed(ContentWidget.name);
            }
          },
        );
      },
    ),
    GoRoute(
      path: ContentWidget.path,
      name: ContentWidget.name,
      builder: (context, state) {
        return ContentWidget();
      },
    ),
  ];
}
