import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/widgets/helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'custom_appoinment_lable.dart';

class DashboardStatsInfo extends StatelessWidget {
  const DashboardStatsInfo({super.key, required this.stats});

  final List<int>? stats;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: stats != null ? stats!.length : 5,
      separatorBuilder: (context, _) => SizedBox(width: 20.w),
      itemBuilder: (_, index) {
        if (stats == null) {
          return InfoItem(
            icon: Icons.people_rounded,
            title: 'loading'.tr(),
            value: 0,
            accentColor: ColorManager.primary,
          );
        }

        return buildInfoItems(stats!)[index];
      },
    );
  }
}
