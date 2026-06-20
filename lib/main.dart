import 'package:clinc_dashboard/core/injection/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'features/auth/presentation/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupServiceLocator();
  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ClincDashboard(),
    ),
  );
}

class ClincDashboard extends StatelessWidget {
  const ClincDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: AppRoutes.routes,
      title: 'Clinc Dashboard',
      initialRoute: SignupScreen.routeName,
    );
  }
}
