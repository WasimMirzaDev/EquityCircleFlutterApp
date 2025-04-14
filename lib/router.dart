import 'package:equitycircle/education_new/presentation/subjects_screens.dart';
import 'package:equitycircle/features/auth/presentation/login_page.dart';
import 'package:equitycircle/features/auth/presentation/register_page.dart';
import 'package:equitycircle/features/bussiness/presentation/bussiness_screen.dart';
import 'package:equitycircle/features/education/education_page.dart';
import 'package:equitycircle/features/event_calender/presentation/event_calender_screen.dart';
import 'package:equitycircle/features/feeds/feedScreen.dart';
import 'package:equitycircle/features/job_application/presentation/job_application_screen.dart';
import 'package:equitycircle/features/job_list/joblist_page.dart';
import 'package:equitycircle/features/splash_screen.dart';
import 'package:equitycircle/layout/main-layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/providers/auth_provider.dart';
import 'education_new/presentation/education_screen.dart';
import 'education_new/presentation/education_tab_screen.dart';
import 'education_new/presentation/video_detail_screen.dart';
import 'features/event_calender/presentation/add_new_event_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',

    // initialLocation: authProvider.isAuthenticated ? '/' : '/login',
    refreshListenable: authProvider,
    routes: [
      /// 🏠 **Main Shell Route** (Wraps Only Bottom Navigation Pages)
      ShellRoute(
        builder:
            (context, state, child) => MainLayout(state: state, child: child),
        routes: [
          _protectedRoute('/', BusinessScreen(categoryId: 1)),
          _protectedRoute('/crypto', BusinessScreen(categoryId: 2)),
          _protectedRoute('/fitness', BusinessScreen(categoryId: 3)),
          _protectedRoute('/mindset', BusinessScreen(categoryId: 4)),
        ],
      ),

      /// 📚 **Standalone Pages (Separate from Bottom Navigation)**
      _protectedStandaloneRoute(
        '/CorporateFinanceScreen',
        CorporateFinanceScreen(),
      ),
      _protectedStandaloneRoute('/VideoDetailScreen', VideoDetailScreen()),
      _protectedStandaloneRoute('/education', EducationPage()),
      _protectedStandaloneRoute('/neweducation', NewEducationScreen()),
      _protectedStandaloneRoute('/SubjectScreen', SubjectScreen()),

      _protectedStandaloneRoute('/Joblist', JoblistPage()),
      _protectedStandaloneRoute('/JobApplication', JobApplicationScreen()),
      _protectedStandaloneRoute('/EventCalender', EventCalenderScreen()),
      _protectedStandaloneRoute('/feedback', FeedbackPage()),
      _protectedStandaloneRoute('/addNewEvent', AddNewEventScreen()),

      /// 🔑 **Authentication Routes**
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),

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
