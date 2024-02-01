import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class InjeConsumerStatefulWidget<VM> extends ConsumerStatefulWidget {
  const InjeConsumerStatefulWidget({super.key});

  ProviderListenable<VM> get viewProvider;

  @override
  ConsumerState<InjeConsumerStatefulWidget> createState();
}
