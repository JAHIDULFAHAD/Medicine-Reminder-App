import 'package:go_router/go_router.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/pages/add_medicine_screen.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/pages/tab_bar%20_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, State) => TabBarScreen()),
    GoRoute(
      path: '/add_medicine',
      builder: (context, State) => AddMedicineScreen(),
    ),
  ],
);
