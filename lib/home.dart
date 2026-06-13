import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/auth/dashboard/presentation/dashboard_tab.dart';
import 'package:clinc_dashboard/tabs.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final tabs = [DashboardTab(), Text("Dashboard 2"), Text("Dashboard 3")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroud,
      body: Row(
        children: [
          Expanded(flex: 1, child: Tabs()),
          Expanded(flex: 4, child: tabs[0]),
        ],
      ),
    );
  }
}
