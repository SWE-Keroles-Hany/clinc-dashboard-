import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'features/auth/presentation/screens/login_screen.dart';

void main() {
  runApp(const ClincDashboard());
}

class ClincDashboard extends StatelessWidget {
  const ClincDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      title: 'Clinc Dashboard',
      initialRoute: LoginScreen.routeName,
    );
  }
}
