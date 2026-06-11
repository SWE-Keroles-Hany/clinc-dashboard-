import 'package:clinc_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ClincDashboard());
}

class ClincDashboard extends StatelessWidget {
  const ClincDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Clinc Dashboard', home: const LoginScreen());
  }
}
