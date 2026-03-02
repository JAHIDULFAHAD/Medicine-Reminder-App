import 'package:go_router/go_router.dart';
import 'package:medicine_reminder_app/app/router/route_paths.dart';
import 'package:medicine_reminder_app/app/router/routes_names.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/pages/add_medicine_screen.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/pages/tab_bar%20_screen.dart';

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RoutePaths.home,
  routes: [
    GoRoute(
      name: RouteNames.home,
      path: RoutePaths.home,
      builder: (context, state) => const TabBarScreen(),
    ),

    GoRoute(
      name: RouteNames.medicineAdd,
      path: RoutePaths.medicineAdd,
      builder: (context, state) => const AddMedicineScreen(),
    ),
  ],
);
