import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class LastConsumerStatefulWidget<VM> extends ConsumerStatefulWidget {
  const LastConsumerStatefulWidget({super.key});

  ProviderListenable<VM> get viewProvider;

  @override
  ConsumerState<LastConsumerStatefulWidget> createState();
}
