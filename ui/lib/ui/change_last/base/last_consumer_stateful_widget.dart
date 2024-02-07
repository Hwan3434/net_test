import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef CreateProvider<NotifierT extends StateNotifier<VM>, VM>
    = StateNotifierProvider<NotifierT, VM> Function();

abstract class LastConsumerStatefulWidget<VM> extends ConsumerStatefulWidget {
  const LastConsumerStatefulWidget({super.key});

  ProviderListenable<VM> get viewProvider;

  @override
  ConsumerState<LastConsumerStatefulWidget> createState();
}
