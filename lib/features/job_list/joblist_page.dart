import 'package:equitycircle/core/providers/job_provider.dart';
import 'package:equitycircle/features/job_list/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class JoblistPage extends StatefulWidget {
  const JoblistPage({super.key});

  @override
  State<JoblistPage> createState() => _JoblistPageState();
}

class _JoblistPageState extends State<JoblistPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<JobProvider>(context, listen: false).getJobLists(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
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
        title: const Text('Job Lists'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: jobProvider.jobLists.length,
        itemBuilder: (context, index) {
          return JobCard(job: jobProvider.jobLists[index]);
        },
      ),
    );
  }
}
