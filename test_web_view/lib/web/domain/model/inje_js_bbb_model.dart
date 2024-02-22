class InjeJsBBBModel {
  final String dataA;
  final int dataB;

  InjeJsBBBModel({
    required this.dataA,
    required this.dataB,
  });

  InjeJsBBBModel.fromJson(Map<String, dynamic> json)
      : dataA = json['dataA'],
        dataB = json['dataB'];

  Map<String, dynamic> toJson() => {
        'dataA': dataA,
        'dataB': dataB,
      };
}
