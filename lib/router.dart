import 'package:equitycircle/features/auth/register_page.dart';
import 'package:equitycircle/features/auth/login_page.dart';
import 'package:equitycircle/features/education/education_page.dart';
import 'package:equitycircle/features/feeds/feedScreen.dart';
import 'package:equitycircle/features/feeds/feeds_page.dart';
import 'package:equitycircle/features/job_list/joblist_page.dart';
import 'package:equitycircle/layout/main-layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/providers/auth_provider.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: authProvider.isAuthenticated ? '/' : '/login',
    refreshListenable: authProvider,
    routes: [
      /// 🏠 **Main Shell Route** (Wraps Only Bottom Navigation Pages)
      ShellRoute(
        builder:
            (context, state, child) => MainLayout(child: child, state: state),
        routes: [
          _protectedRoute('/', FeedsPage(categoryId: 1)),
          _protectedRoute('/crypto', FeedsPage(categoryId: 2)),
          _protectedRoute('/fitness', FeedsPage(categoryId: 3)),
          _protectedRoute('/mindset', FeedsPage(categoryId: 4)),
        ],
      ),

      /// 📚 **Standalone Pages (Separate from Bottom Navigation)**
      _protectedStandaloneRoute('/education', EducationPage()),
      _protectedStandaloneRoute('/Joblist', JoblistPage()),
      _protectedStandaloneRoute('/feedback', FeedbackPage()),

      /// 🔑 **Authentication Routes**
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
        redirect: (context, state) => authProvider.isAuthenticated ? '/' : null,
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
        redirect: (context, state) => authProvider.isAuthenticated ? '/' : null,
      ),
    ],
  );
}

/// 📌 **Helper Function for Routes that Don't Use MainLayout**
GoRoute _protectedStandaloneRoute(String path, Widget page) {
  return GoRoute(
    path: path,
    builder: (context, state) => page,
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      return authProvider.isAuthenticated ? null : '/login';
    },
  );
}

/// 📌 **Helper Function for Protected Routes**
GoRoute _protectedRoute(String path, Widget page) {
  return GoRoute(
    path: path,
    builder: (context, state) => page,
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      return authProvider.isAuthenticated ? null : '/login';
    },
  );
}
