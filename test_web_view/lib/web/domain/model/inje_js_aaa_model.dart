class InjeJsAAAModel {
  final String dataA;
  final String dataB;

  InjeJsAAAModel({
    required this.dataA,
    required this.dataB,
  });

  InjeJsAAAModel.fromJson(Map<String, dynamic> json)
      : dataA = json['dataA'],
        dataB = json['dataB'] as String? ?? '';
}
