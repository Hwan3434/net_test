class OriginalWidgetViewModel {
  final int count;
  final String text;

  const OriginalWidgetViewModel({
    required this.count,
    required this.text,
  });

  OriginalWidgetViewModel copyWith({
    int? count,
    String? text,
  }) {
    return OriginalWidgetViewModel(
      count: count ?? this.count,
      text: text ?? this.text,
    );
  }
}
