import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class FilterList extends StatefulWidget {
  const FilterList({super.key});

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  final list = ['all', 'pending', 'completed', 'cancelled', 'confirmed'];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(width: 10.w),
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          selectedIndex = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? ColorManager.primary
                : ColorManager.kGray500,
            borderRadius: BorderRadius.circular(8.r),
            border: BoxBorder.all(color: Colors.transparent),
          ),
          child: Text(
            list[index].tr(),
            style: AppTextStyles.s14bold.copyWith(color: ColorManager.white),
          ),
        ),
      ),
    );
  }
}
