class SplashModel {
  final int count;
  final bool splashLoading;

  const SplashModel({
    required this.count,
    required this.splashLoading,
  });

  SplashModel copyWith({
    int? count,
    bool? splashLoading,
  }) {
    return SplashModel(
      count: count ?? this.count,
      splashLoading: splashLoading ?? this.splashLoading,
    );
  }
}
