import 'dart:developer';

import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_cubit.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesCard extends StatelessWidget {
  const PreferencesCard({super.key, required this.labelStyle});

  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            log("language is => ${state.languageCode}");
            final currentLanguage = state.languageCode;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.tune, color: ColorManager.primary),
                    const SizedBox(width: 8),
                    Text('preferences'.tr(), style: AppTextStyles.s18bold),
                  ],
                ),
                const SizedBox(height: 12),
                Text('language_selection'.tr(), style: labelStyle),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ColorManager.lightGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: currentLanguage,
                    underline: const SizedBox(),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('english'.tr()),
                      ),
                      DropdownMenuItem(value: 'ar', child: Text('arabic'.tr())),
                    ],
                    onChanged: (newValue) {
                      if (newValue != null) {
                        context.read<SettingsCubit>().changeLanguage(newValue);
                      }
                    },
                  ),
                ),
                // const SizedBox(height: 12),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text('dark_mode'.tr(), style: AppTextStyles.s14bold),
                //     Switch(value: false, onChanged: (_) {}),
                //   ],
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
