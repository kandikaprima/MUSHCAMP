import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/capture_page.dart';
import '../../presentation/pages/detail_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/capture',
        name: 'capture',
        builder: (context, state) => const CapturePage(),
      ),
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) => const DetailPage(),
      ),
    ],
  );
}