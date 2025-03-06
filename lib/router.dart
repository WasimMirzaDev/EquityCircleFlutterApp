import 'package:equitycircle/features/auth/register_page.dart';
import 'package:equitycircle/features/feeds/feedNav.dart';
import 'package:equitycircle/features/feeds/feedScreen.dart';
import 'package:equitycircle/layout/main-layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/login_page.dart';
import 'features/home/home_page.dart';
import 'features/feeds/feeds_page.dart';
import 'package:provider/provider.dart';
import 'core/providers/auth_provider.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(); // ✅ Required to fix the error

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  refreshListenable: AuthProvider(),
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child, state: state);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => FeedsPage(categoryId: 1),
          redirect: (context, state) {
            final authProvider = Provider.of<AuthProvider>(
              context, // ✅ Use safely
              listen: false,
            );
            return authProvider.isAuthenticated ? null : '/login';
          },
        ),
        GoRoute(
          path: '/crypto',
          builder: (context, state) => FeedsPage(categoryId: 2),
          redirect: (context, state) {
            final authProvider = Provider.of<AuthProvider>(
              context, // ✅ Safe access
              listen: false,
            );
            return authProvider.isAuthenticated ? null : '/login';
          },
        ),
        GoRoute(
          path: '/fitness',
          builder: (context, state) => FeedsPage(categoryId: 3),
          redirect: (context, state) {
            final authProvider = Provider.of<AuthProvider>(
              context, // ✅ Safe access
              listen: false,
            );
            return authProvider.isAuthenticated ? null : '/login';
          },
        ),
        GoRoute(
          path: '/mindset',
          builder: (context, state) => FeedsPage(categoryId: 4),
          redirect: (context, state) {
            final authProvider = Provider.of<AuthProvider>(
              context, // ✅ Safe access
              listen: false,
            );
            return authProvider.isAuthenticated ? null : '/login';
          },
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        return authProvider.isAuthenticated ? '/' : null;
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        return authProvider.isAuthenticated ? '/' : null;
      },
    ),

    GoRoute(
      path: '/feedback',
      builder: (context, state) => Feednav(),
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        return authProvider.isAuthenticated ? null : '/login';
      },
    ),
  ],
);
