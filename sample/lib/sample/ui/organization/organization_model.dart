class OrganizationModel {
  final String org;

  const OrganizationModel({
    required this.org,
  });

  OrganizationModel copyWith({
    String? org,
  }) {
    return OrganizationModel(
      org: org ?? this.org,
    );
  }
}
