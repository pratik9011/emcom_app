import 'view_list.dart'
    show
        AddComment,
        BottomNavigationBarExample,
        DeleteAccount,
        EditProfile,
        GetPage,
        HelpSupport,
        HomeScreen,
        LoginScreen,
        MyBindings,
        NotificationScreen,
        ProfileScreen,
        ServerMaintenanceScreen,
        ShowTaskScreen,
        TaskDetails,
        TaskScreen,
        Transition;

class AppRoutes {
  static final routes = [
    GetPage(
        name: '/home',
        page: () => const HomeScreen(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),
    GetPage(
      name: '/mainPage',
      page: () => const BottomNavigationBarExample(),
      binding: MyBindings(),
    ),




    GetPage(
        name: '/notification',
        page: () => const NotificationScreen(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/profileEdit',
        page: () => const EditProfile(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/helpSupport',
        page: () => const HelpSupport(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),

    GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/deleteAccount',
        page: () => const DeleteAccount(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/serverMaintenancePage',
        page: () => const ServerMaintenanceScreen(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/profile',
        page: () => const ProfileScreen(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/editProfile',
        page: () => const EditProfile(),
        binding: MyBindings(),
        transition: Transition.rightToLeft),
  ];
}
