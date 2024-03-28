class JsLazyChannel {
  final String name;

  const JsLazyChannel({
    required this.name,
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
