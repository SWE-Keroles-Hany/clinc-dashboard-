import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/clinic_information_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/account_settings_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/preferences_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/need_help_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_cubit.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isEditing = false;

  late final TextEditingController clinicNameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController websiteController;
  late final TextEditingController addressController;
  late final TextEditingController profileNameController;
  late final TextEditingController personalEmailController;

  @override
  void initState() {
    context.read<SettingsCubit>().loadLanguage();

    super.initState();
    clinicNameController = TextEditingController(
      text: 'MedCore General Hospital',
    );
    phoneController = TextEditingController(text: '+1 (555) 902-1000');
    emailController = TextEditingController(text: 'admin@medcore.hospital');
    websiteController = TextEditingController(text: 'https://medcore.hospital');
    addressController = TextEditingController(
      text: '1200 Healthcare Way, Medical District, San Francisco, CA 94103',
    );
    profileNameController = TextEditingController(text: 'Dr. Jonathan Smith');
    personalEmailController = TextEditingController(
      text: 'j.smith@medcore.hospital',
    );
  }

  @override
  void dispose() {
    clinicNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    addressController.dispose();
    profileNameController.dispose();
    personalEmailController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration() => InputDecoration(
    filled: true,
    fillColor: ColorManager.lightGray,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      _isEditing = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('settings_saved'.tr())));
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.s14bold.copyWith(
      color: ColorManager.kGray500,
    );

    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded) {
          final currentLocale = EasyLocalization.of(
            context,
          )?.locale.languageCode;
          if (currentLocale != state.languageCode) {
            context.setLocale(Locale(state.languageCode));
          }
          setState(() {});
        }
      },
      child: Container(
        color: ColorManager.backgroud,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Top row with title and save button
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'system_settings'.tr(),
                        style: AppTextStyles.s30bold,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'manage_clinic_preferences'.tr(),
                        style: AppTextStyles.s14bold.copyWith(
                          color: ColorManager.kGray500,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _saveChanges,
                  icon: const Icon(Icons.save),
                  label: Text('save_changes'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Main content two-column layout
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left main column
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        ClinicInformationCard(
                          clinicNameController: clinicNameController,
                          phoneController: phoneController,
                          emailController: emailController,
                          websiteController: websiteController,
                          addressController: addressController,
                          isEditing: _isEditing,
                          onToggleEdit: _toggleEdit,
                          inputDecoration: _inputDecoration(),
                          labelStyle: labelStyle,
                        ),

                        const SizedBox(height: 16),

                        AccountSettingsCard(
                          profileNameController: profileNameController,
                          personalEmailController: personalEmailController,
                          isEditing: _isEditing,
                          inputDecoration: _inputDecoration(),
                          labelStyle: labelStyle,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Right sidebar
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        PreferencesCard(labelStyle: labelStyle),
                        const SizedBox(height: 12),
                        const NeedHelpCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
