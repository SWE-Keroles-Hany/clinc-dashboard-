import 'dart:developer';
import 'dart:typed_data';

import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/utils/ui_utils.dart';
import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/clinic_information_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/account_settings_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/preferences_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/need_help_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/working_days_card.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_cubit.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:image_picker/image_picker.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isEditing = false;
  Uint8List? _prescriptionBytes;
  String? _fileName;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickFile(BuildContext context) async {
    final cubit = context.read<SettingsCubit>();
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _prescriptionBytes = bytes;
        _fileName = pickedFile.name;
      });
      log("befofe cubit $_prescriptionBytes");
      cubit.updateProfileImage(_prescriptionBytes, _fileName);
    }
  }

  late final TextEditingController specialtyController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController yearsOfExperienceController;
  late final TextEditingController addressController;
  late final TextEditingController bioController;
  late final TextEditingController profileNameController;
  late final TextEditingController personalEmailController;
  DoctorModel? _doctor;
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    specialtyController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    yearsOfExperienceController = TextEditingController();
    addressController = TextEditingController();
    bioController = TextEditingController();
    profileNameController = TextEditingController();
    personalEmailController = TextEditingController();

    final cubit = context.read<SettingsCubit>();
    cubit.loadLanguage();
    cubit.getProfile();
    // cubit.getWorkingDays();
  }

  @override
  void dispose() {
    specialtyController.dispose();
    phoneController.dispose();
    emailController.dispose();
    yearsOfExperienceController.dispose();
    addressController.dispose();
    bioController.dispose();
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

  void _evictProfileImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return;
    NetworkImage(imageUrl).evict();
  }

  void _saveChanges() {
    final currentDoctor = _doctor;
    if (currentDoctor == null) return;

    context.read<SettingsCubit>().updateProfile(
      doctor: DoctorModel(
        fullName: profileNameController.text.trim(),
        email: currentDoctor.email,
        phoneNumber: phoneController.text.trim(),
        specialty: specialtyController.text.trim(),
        yearsOfExperience:
            int.tryParse(yearsOfExperienceController.text.trim()) ?? 0,
        clinicAddress: addressController.text.trim(),
        bio: bioController.text.trim(),
        profilePictureUrl: currentDoctor.profilePictureUrl,
        password: currentDoctor.password,
        gender: currentDoctor.gender,
      ),
      profileImagePath: _selectedImagePath,
    );
  }

  void _bindProfile(DoctorModel doctor) {
    _doctor = doctor;
    profileNameController.text = doctor.fullName;
    personalEmailController.text = doctor.email;
    emailController.text = doctor.email;
    phoneController.text = doctor.phoneNumber;
    specialtyController.text = doctor.specialty;
    yearsOfExperienceController.text = (doctor.yearsOfExperience ?? 0)
        .toString();
    addressController.text = doctor.clinicAddress ?? '';
    bioController.text = doctor.bio ?? '';
    _selectedImagePath = doctor.profilePictureUrl;
  }

  @override
  Widget build(BuildContext context) {
    log(_doctor?.profilePictureUrl ?? "no doc");
    final labelStyle = AppTextStyles.s14bold.copyWith(
      color: ColorManager.kGray500,
    );

    return BlocConsumer<SettingsCubit, SettingsState>(
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
        if (state is SettingsProfileLoaded && state.doctor != null) {
          _bindProfile(state.doctor!);
        }
        if (state is SettingsProfileUpdated) {
          setState(() {
            _isEditing = false;
            if (state.doctor != null) {
              _doctor = state.doctor;
            }
          });
          _evictProfileImage(state.doctor?.profilePictureUrl);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('settings_saved'.tr())));
        }
        if (state is SettingsProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isSaving = state is SettingsProfileUpdating;
        return Container(
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
                    onPressed: isSaving ? null : _saveChanges,
                    icon: const Icon(Icons.save),
                    label: Text(
                      isSaving ? 'loading'.tr() : 'save_changes'.tr(),
                    ),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ClinicInformationCard(
                              specialtyController: specialtyController,
                              phoneController: phoneController,
                              emailController: emailController,
                              yearsOfExperienceController:
                                  yearsOfExperienceController,
                              addressController: addressController,
                              bioController: bioController,
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

                            const SizedBox(height: 16),

                            const WorkingDaysCard(),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),
                    // Right sidebar
                    Expanded(
                      flex: 1,
                      child: BlocListener<SettingsCubit, SettingsState>(
                        listener: (context, state) {
                          if (state is UpdateProfileImageError) {
                            UiUtils.showSnackBar(context, state.message);
                          } else if (state is UpdateProfileImageSuccessfully) {
                            UiUtils.showSnackBar(
                              context,
                              "Your Image Updated Successfully",
                            );
                            context.read<SettingsCubit>().getProfile();
                          } else if (state is UpdateProfileImageLoading) {
                            UiUtils.showSnackBar(
                              context,
                              "Updating The Image....",
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 200.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorManager.primary.withValues(
                                    alpha: 0.15,
                                  ),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  _selectedImagePath ?? "",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      size: 80.sp,
                                      color: ColorManager.kGray500,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            IconButton(
                              onPressed: () => _pickFile(context),
                              icon: Icon(
                                Icons.edit,
                                color: ColorManager.primary,
                              ),
                            ),
                            SizedBox(height: 12.h),

                            PreferencesCard(labelStyle: labelStyle),
                            SizedBox(height: 12.h),
                            const NeedHelpCard(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
