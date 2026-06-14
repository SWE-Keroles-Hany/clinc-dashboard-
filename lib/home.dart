import 'package:clinc_dashboard/core/theme/color_manger.dart';

import 'package:clinc_dashboard/features/dashboard/presentation/cubit/dashboard_cubit_provider.dart';

import 'package:clinc_dashboard/features/dashboard/presentation/dashboard_tab.dart';

import 'package:clinc_dashboard/tabs.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';



class Home extends StatelessWidget {
  static const String routeName = "Home";
  Home({super.key});



  final tabs = [
    const DashboardTab(),
    const Text("Dashboard 2"),
    const Text("Dashboard 3"),
  ];



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: ColorManager.backgroud,

      body: Row(

        children: [

          const Expanded(flex: 1, child: Tabs()),

          Expanded(
            flex: 4,

            child: BlocProvider(
              create: (_) => createDashboardCubit(),

              child: tabs[0],
            ),
          ),

        ],

      ),

    );

  }

}


