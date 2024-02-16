enum LastTabs {
  content,
  setting,
}

class LastViewModel {
  final LastTabs currentTab;

  const LastViewModel({
    required this.currentTab,
  });

  LastViewModel copyWith({
    LastTabs? currentTab,
  }) {
    return LastViewModel(
      currentTab: currentTab ?? this.currentTab,
    );
  }
}
