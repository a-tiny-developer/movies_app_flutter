import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'router/router.dart';
import 'theme/theme.dart';
import 'providers/providers.dart';

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: const MoviesApp(),
    );
  }
}

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
