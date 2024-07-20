// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test/view/screens/form/form_screen.dart';
import 'package:test/view/screens/home_screen.dart';
import 'package:test/view/screens/register_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    // * Test routes after deploying json files on domain
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: RegisterScreen.routeName,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: FormScreen.routeName,
          builder: (context, state) => const FormScreen(),
        ),
      ],
    )
  ],
);
