import 'package:equitycircle/core/providers/education_provider.dart';
import 'package:equitycircle/features/education/widgets/education_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<EducationProvider>(
        context,
        listen: false,
      ).getEducation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final educationProvider = Provider.of<EducationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.canPop()) {
                context.pop(); // 🔄 Goes back safely
              } else {
                context.go('/'); // 🏠 Fallback if no previous page
              }
            });
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Education Content'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: educationProvider.educationContent.length,
        itemBuilder: (context, index) {
          return EducationCard(
            education: educationProvider.educationContent[index],
          );
        },
      ),
    );
  }
}
