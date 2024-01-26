import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentProvider = StateProvider<Current>((ref) {
  return Current();
});

class Current {
  final String env;
  final String org;
  final String service;

  Current({
    this.env = 'dev',
    this.org = '',
    this.service = '',
  });

  Current copyWith({
    String? env,
    String? org,
    String? service,
  }) {
    return Current(
      env: env ?? this.env,
      org: org ?? this.org,
      service: service ?? this.service,
    );
  }
}
