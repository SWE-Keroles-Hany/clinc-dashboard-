import 'package:clinc_dashboard/core/helper/validations/app_validations.dart';
import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/custom_button.dart';
import 'package:clinc_dashboard/features/auth/domain/entities/doctor_entity.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_states.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/custom_dropdown.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final specialtyController = TextEditingController();
  bool isAgreedToTerms = false;
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('registration_successful'.tr())),
          );
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }

        if (state is RegisterError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'create_your_account'.tr(),
                    style: AppTextStyles.s40bold.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  Text(
                    'secure_access_practitioners'.tr(),
                    style: AppTextStyles.s18bold.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  CustomInputField(
                    icon: Icons.person,
                    hintText: 'name_hint'.tr(),
                    keyboardType: TextInputType.text,
                    title: 'full_name'.tr(),
                    controller: fullNameController,
                    validator: AppValidations.nameValidator,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomInputField(
                          icon: Icons.medical_services_rounded,
                          hintText: 'specialty_hint'.tr(),
                          keyboardType: TextInputType.text,
                          title: 'specialty'.tr(),
                          controller: specialtyController,
                          validator: AppValidations.nameValidator,
                        ),
                      ),
                      SizedBox(width: 15.w),

                      Expanded(
                        flex: 1,
                        child: CustomDropDown(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'select_gender'.tr();
                            }
                            return null;
                          },
                          label: 'gender'.tr(),
                          value: selectedGender,
                          items: [
                            'male'.tr(),
                            'female'.tr(),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedGender = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    icon: Icons.phone,
                    hintText: 'phone_hint'.tr(),
                    keyboardType: TextInputType.phone,
                    title: 'phone_number'.tr(),
                    controller: phoneNumberController,
                    validator: AppValidations.phoneNumberValidator,
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    icon: Icons.email,
                    hintText: 'email_hint'.tr(),
                    keyboardType: TextInputType.emailAddress,
                    title: 'email_address'.tr(),
                    controller: emailController,
                    validator: AppValidations.emailValidator,
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    isPasswordField: true,
                    icon: Icons.lock,
                    hintText: 'password_hint'.tr(),
                    title: 'password'.tr(),
                    controller: passwordController,
                    validator: (value) =>
                        AppValidations.passwordValidator(value: value),
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    isPasswordField: true,
                    icon: Icons.lock,
                    hintText: 'password_hint'.tr(),
                    title: 'confirm_password'.tr(),
                    controller: confirmPasswordController,
                    validator: (value) =>
                        AppValidations.confirmPasswordValidator(
                          value: value,
                          password: passwordController.text.trim(),
                        ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Checkbox(
                        side: BorderSide(color: ColorManager.black),
                        checkColor: ColorManager.white,
                        activeColor: ColorManager.primary,
                        value: isAgreedToTerms,
                        onChanged: (isChecked) {
                          setState(() {
                            isAgreedToTerms = isChecked ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'terms_agree'.tr(),
                          style: AppTextStyles.s18bold.copyWith(
                            color: ColorManager.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (!(_formKey.currentState!.validate() &&
                                selectedGender?.isNotEmpty == true)) {
                              return;
                            }
                            if (!isAgreedToTerms) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('please_agree_terms'.tr()),
                                ),
                              );
                              return;
                            }

                            final doctor = DoctorEntity(
                              fullName: fullNameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              gender: selectedGender ?? 'Male',
                              phoneNumber: phoneNumberController.text.trim(),
                              specialty: specialtyController.text.trim(),
                              yearsOfExperience: 0,
                              clinicAddress: "null",
                              bio: "",
                              profilePictureUrl: "null",
                            );

                            context.read<AuthCubit>().register(doctor: doctor);
                          },
                    title: isLoading ? 'creating_account'.tr() : 'sign_up'.tr(),
                    titleColor: ColorManager.white,
                    bgColor: ColorManager.primary,
                    width: width,
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'already_have_account'.tr(),
                        style: AppTextStyles.s20bold,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        },
                        child: Text(
                          'login'.tr(),
                          style: AppTextStyles.s20bold.copyWith(
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
