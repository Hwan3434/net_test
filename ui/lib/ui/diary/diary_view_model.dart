class DiaryViewModel {
  final List<String> appbarBottomMenuItems;
  final String selectedAppBarBottomMenu;

  final List<String> bottomNavigationItems;
  final String selectedBottomNavigationMenu;

  const DiaryViewModel({
    required this.appbarBottomMenuItems,
    required this.selectedAppBarBottomMenu,
    required this.bottomNavigationItems,
    required this.selectedBottomNavigationMenu,
  });
}
