enum UserPageViews {
  user,
  cache,
}

class UserScreenModel {
  final UserPageViews selectedTab;

  UserScreenModel({
    required this.selectedTab,
  });

  UserScreenModel copyWith({
    UserPageViews? selectedTab,
  }) {
    return UserScreenModel(selectedTab: selectedTab ?? this.selectedTab);
  }
}
