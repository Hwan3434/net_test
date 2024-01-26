// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_manager_buffer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userManagerBufferHash() => r'ebfaeb5b563a2da6eaafc2f802a4f4d6e017d745';

/// 사용목적
/// 우리는 주소값을 참조하도록 하고싶지만
/// Riverpod는 state에 새로운 값 대입을 기점으로 rebuild를 하기 때문에 주소값이 변경되어버린다.
/// 그래서 singleton의 상태를 파악하기위해 얘를 사용합니다.
/// Singleton 데이터 변화를 감지하려면 이녀석을 watch해야합니다.
///
/// Copied from [UserManagerBuffer].
@ProviderFor(UserManagerBuffer)
final userManagerBufferProvider =
    NotifierProvider<UserManagerBuffer, UserManagerSingletonState>.internal(
  UserManagerBuffer.new,
  name: r'userManagerBufferProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userManagerBufferHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserManagerBuffer = Notifier<UserManagerSingletonState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
