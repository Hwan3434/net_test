import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UseCaseStateNotifier extends StateNotifier<UseCaseStateModel> {
  UseCaseStateNotifier(final UseCaseStateModel state) : super(state);

  void update({
    String? domain,
    String? org,
    String? service,
  }) {
    debugPrint('service :: $service');
    state = state.copyWith(
      domain: domain ?? state.domain,
      org: org ?? state.org,
      service: service ?? state.service,
    );
  }
}

class UseCaseStateModel {
  final String domain;
  final String service;
  final String org;

  UseCaseStateModel({
    this.domain = 'dev',
    required this.org,
    required this.service,
  });

  UseCaseStateModel copyWith({
    String? domain,
    String? org,
    String? service,
  }) {
    return UseCaseStateModel(
      domain: domain ?? this.domain,
      org: org ?? this.org,
      service: service ?? this.service,
    );
  }
}
