import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/router_provider.dart';
import 'package:sample/sample/data/info/app_info_manager.dart';
import 'package:sample/sample/data/shared/shared_data_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInfoManger().init();
  await SharedDataManger().init();

  final env = AppInfoManger().getEnvironment();

  runApp(
    ProviderScope(
      observers: [],
      child: env.create(
        RouterWidget(),
      ),
    ),
  );
}

class RouterWidget extends ConsumerWidget {
  const RouterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: false),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
