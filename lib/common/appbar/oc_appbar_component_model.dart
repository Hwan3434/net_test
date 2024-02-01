class OcAppbarComponentModel {
  final String name;

  OcAppbarComponentModel({required this.name});

  OcAppbarComponentModel copyWith({
    String? name,
  }) {
    return OcAppbarComponentModel(
      name: name ?? this.name,
    );
  }
}
