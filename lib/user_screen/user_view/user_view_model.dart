enum UserPageViews {
  provider,
  buffer,
}

class UserViewModel {
  final UserPageViews selectedTab;

  UserViewModel({
    required this.selectedTab,
  });

  UserViewModel copyWith({
    UserPageViews? selectedTab,
  }) {
    return UserViewModel(selectedTab: selectedTab ?? this.selectedTab);
  }
}
