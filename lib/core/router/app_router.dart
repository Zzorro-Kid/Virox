import 'package:flutter/material.dart';

import '../../features/main_screen/presentation/pages/main_screen.dart';
import '../../features/search_screen/presentation/pages/search_poisons_page.dart';

class AppRouter {
  static const String searchPage = '/search-page';
  static const String mainScreen = '/main-screen';

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case searchPage:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
