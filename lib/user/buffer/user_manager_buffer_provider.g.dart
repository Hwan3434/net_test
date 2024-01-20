// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_manager_buffer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userManagerBufferHash() => r'a0966eb1b00cf8eb8909bfdfdaa6b86c712257ed';

/// 사용목적
/// 우리는 주소값을 참조하도록 하고싶지만
/// Riverpod는 state에 새로운 값 대입을 기점으로 rebuild를 하기 때문에 주소값이 변경되어버린다.
/// 그래서 우린 singleton을 업데이트 해주고
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
