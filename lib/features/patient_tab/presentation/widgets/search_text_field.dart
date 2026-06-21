import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required TextEditingController searchController,
    this.onChanged,
    this.onTap,
  }) : _searchController = searchController;
  final Function()? onTap;
  final TextEditingController _searchController;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      controller: _searchController,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'search_patients'.tr(),
        hintStyle: AppTextStyles.s14bold.copyWith(
          color: ColorManager.kGray500,
          fontWeight: FontWeight.normal,
          fontSize: 13.sp,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: ColorManager.kGray500,
          size: 18.sp,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
      ),
    );
  }
}
