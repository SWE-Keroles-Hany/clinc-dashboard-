import 'package:clinc_dashboard/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ClincDashboard());
}

class ClincDashboard extends StatelessWidget {
  const ClincDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      // routes: AppRoutes.routes,
      title: 'Clinc Dashboard',
      // initialRoute: SignupScreen.routeName,
    );
  }
}
