import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/clinc_title_and_subtitle.dart';
import 'package:clinc_dashboard/core/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class Tabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const Tabs({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final tabsItem = [
      TabItem(title: "Dashboard", icon: Icons.dashboard, onTap: () {}),
      TabItem(title: "Patients", icon: Icons.people, onTap: () {}),
      TabItem(title: "Appointments", icon: Icons.calendar_today, onTap: () {}),
      TabItem(title: "AI Chatting", icon: Icons.chat, onTap: () {}),
      TabItem(title: "Settings", icon: Icons.settings, onTap: () {}),
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: ColorManager.kGray500, width: 0.5.w),
        ),
      ),
      child: Drawer(
        width: width * 0.18,
        backgroundColor: ColorManager.backgroud,
        shape: const BeveledRectangleBorder(),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, top: 20.h, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ClincTitleAndSubtitle(),
              SizedBox(height: 25.h),
              SizedBox(
                height: 400.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => TabItem(
                    isSelected: index == selectedIndex,
                    title: tabsItem[index].title,
                    icon: tabsItem[index].icon,
                    onTap: () => onTabSelected(index),
                  ),
                  itemCount: tabsItem.length,
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                ),
              ),
              const Spacer(),
              TabItem(
                isSelected: selectedIndex == 5,
                title: "Logout",
                icon: Icons.logout,
                onTap: () => onTabSelected(5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
