import 'package:flutter/material.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes,
      theme: AppTheme.lighTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
