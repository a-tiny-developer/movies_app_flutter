import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static const screensOptions = <ScreenRoute>[
    ScreenRoute(
      route: initialRoute,
      screen: HomeScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> get getAppRoutes {
    final appRoutes = <String, Widget Function(BuildContext)>{};
    for (final option in screensOptions) {
      appRoutes.addAll({
        option.route: (BuildContext context) => option.screen,
      });
    }
    return appRoutes;
  }
}
