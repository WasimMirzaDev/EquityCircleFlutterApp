// lib/main.dart
import 'package:equitycircle/app.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/providers/education_provider.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:equitycircle/core/providers/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<FeedsProvider>(create: (_) => FeedsProvider()),
        ChangeNotifierProvider<EducationProvider>(
          create: (_) => EducationProvider(),
        ),
        ChangeNotifierProvider<JobProvider>(create: (_) => JobProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
