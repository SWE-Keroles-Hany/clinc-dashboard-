import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.value,
    required this.onChanged,
    this.validator,
    required this.items,
    this.label,
  });

  final List<String> items;
  final String? value;
  final String? label;

  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: AppTextStyles.s18bold.copyWith(color: ColorManager.black),
        ),
        FormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: ValueKey(value),
          initialValue: value,
          validator: validator,

          builder: (fieldState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownMenu<String>(
                  showTrailingIcon: true,
                  selectOnly: true,
                  enableFilter: false,
                  enableSearch: false,
                  hintText: "Male",
                  width: 250.w,
                  initialSelection: fieldState.value,
                  textStyle: AppTextStyles.s14bold,
                  inputDecorationTheme: InputDecorationTheme(
                    errorBorder: errorBorder(),
                    enabledBorder: border(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 10.w,
                    ),
                    filled: true,
                    fillColor: ColorManager.lightGray,
                    // border: InputBorder.none,
                  ),
                  menuStyle: MenuStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      ColorManager.lightGray,
                    ),
                  ),
                  trailingIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: ColorManager.black,
                  ),
                  dropdownMenuEntries: items
                      .map(
                        (type) =>
                            DropdownMenuEntry<String>(value: type, label: type),
                      )
                      .toList(),
                  onSelected: (selected) {
                    fieldState.didChange(selected);
                    onChanged(selected);
                  },
                ),
                if (fieldState.hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 4.w),
                    child: Text(
                      fieldState.errorText ?? "",
                      style: textTheme.labelMedium!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.red,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    );
  }

  OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorManager.red, width: 3),
    );
  }
}
