import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_reminder_app/app/router/routes_names.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/pages/history_screen.dart';
import 'home_page.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medicine Reminder'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: const TabBarView(children: [HomePage(), HistoryScreen()]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(RouteNames.medicineAdd);
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
