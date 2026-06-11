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
    return FormField<String>(
      key: ValueKey(value),
      initialValue: value,
      validator:
          validator ??
          (v) {
            if (v == null || v.isEmpty) return "Please $label";
            return null;
          },
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownMenu<String>(
              width: 250.w,
              initialSelection: fieldState.value,
              textStyle: textTheme.titleMedium!.copyWith(
                color: ColorManager.white,
              ),
              label: Text(
                label ?? "",
                style: textTheme.titleMedium!.copyWith(
                  color: ColorManager.mediumGray,
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: ColorManager.darkTealGreen,
                border: border(Colors.grey),
                enabledBorder: border(Colors.grey),
                focusedBorder: border(ColorManager.aquaMint),
              ),
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(ColorManager.white),
              ),
              trailingIcon: const Icon(
                Icons.arrow_drop_down,
                color: ColorManager.white,
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
                    color: ColorManager.red,
                    fontSize: 14.sp,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }
}
