import 'package:flutter/material.dart';

import '../../features/all_poisons_screen/presentation/pages/all_poisons_screen.dart';
import '../../features/main_screen/presentation/pages/main_screen.dart';
import '../../features/search_screen/presentation/pages/search_poisons_screen.dart';

class AppRouter {
  static const String searchPage = '/search-page';
  static const String mainScreen = '/main-screen';
  static const String allPoisonsScreenPage = '/allPoisons-screen';

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case searchPage:
        return MaterialPageRoute(builder: (_) => const SearchPoisonsScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case allPoisonsScreenPage:
        return MaterialPageRoute(builder: (_) => const AllPoisonsScreenPage());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
