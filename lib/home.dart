import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/appointments_tab.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_states.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:clinc_dashboard/features/dashboard/presentation/cubit/dashboard_cubit_provider.dart';
import 'package:clinc_dashboard/features/dashboard/presentation/dashboard_tab.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_cubit_provider.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/patient_tab.dart';
import 'package:clinc_dashboard/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/settings_tab/presentation/settings_tab.dart';

class Home extends StatefulWidget {
  static const String routeName = "Home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      BlocProvider(
        create: (_) => createDashboardCubit(),
        child: const DashboardTab(),
      ),
      BlocProvider(
        create: (_) => createPatientCubit(),
        child: const PatientTab(),
      ),
      AppointmentsTab(),
      const Center(child: Text("Chatting")),
      SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else if (state is LogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.backgroud,
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Tabs(
                selectedIndex: _selectedIndex,
                onTabSelected: (index) {
                  if (index == 5) {
                    context.read<AuthCubit>().logOut();
                  } else {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: IndexedStack(index: _selectedIndex, children: _tabs),
            ),
          ],
        ),
      ),
    );
  }
}
