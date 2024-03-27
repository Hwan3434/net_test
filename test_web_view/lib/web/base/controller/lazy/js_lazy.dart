class JsLazy {
  final String responseFunctionName;

  const JsLazy({
    required this.responseFunctionName,
  });
}

class LazyModel {
  final bool lazyComplete;

  const LazyModel({
    required this.lazyComplete,
  });

  LazyModel.fromJson(Map<String, dynamic> json)
      : lazyComplete = json['lazyComplete'];

  Map<String, dynamic> toJson() => {
        'lazyComplete': lazyComplete,
      };
}
