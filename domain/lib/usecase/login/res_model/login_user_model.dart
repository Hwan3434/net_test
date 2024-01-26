class LoginUserModel {
  final int id;
  final String name;

  LoginUserModel({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginUserModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
