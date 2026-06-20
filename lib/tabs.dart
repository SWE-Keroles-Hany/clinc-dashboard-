import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/clinc_title_and_subtitle.dart';
import 'package:clinc_dashboard/core/widgets/tab_item.dart';
import 'package:easy_localization/easy_localization.dart';
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
      TabItem(title: "dashboard".tr(), icon: Icons.dashboard, onTap: () {}),
      TabItem(title: "patients".tr(), icon: Icons.people, onTap: () {}),
      TabItem(title: "appointments".tr(), icon: Icons.calendar_today, onTap: () {}),
      TabItem(title: "settings".tr(), icon: Icons.settings, onTap: () {}),
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
                isSelected: selectedIndex == 4,
                title: "logout".tr(),
                icon: Icons.logout,
                onTap: () {
                  showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('confirm_logout'.tr()),
                      content: Text('are_you_sure_logout'.tr()),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('cancel'.tr()),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text('logout'.tr()),
                        ),
                      ],
                    ),
                  ).then((confirmed) {
                    if (confirmed == true) {
                      onTabSelected(5);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
