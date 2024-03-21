import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class Listener<T> extends Mock {
  void call(T? previous, T value);
}

ProviderContainer createContainer<T>(
  ProviderBase<T> provider,
  Listener<T> lis, {
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  container.listen<T>(
    provider,
    lis,
    fireImmediately: true,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}
