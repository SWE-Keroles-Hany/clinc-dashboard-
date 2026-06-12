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
import 'package:dropdown_button2/dropdown_button2.dart';
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
            const SnackBar(content: Text('Registration successful')),
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
                    'Create Your Account',
                    style: AppTextStyles.s40bold.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  Text(
                    'Secure access for medical practitioners',
                    style: AppTextStyles.s18bold.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  CustomInputField(
                    icon: Icons.person,
                    hintText: 'Keroles Hany',
                    keyboardType: TextInputType.text,
                    title: 'Full Name',
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
                          hintText: 'Dental',
                          keyboardType: TextInputType.text,
                          title: 'Specialty',
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
                              return 'Please select The Gender';
                            }
                            return null;
                          },
                          label: 'Gender',
                          value: selectedGender,
                          items: const ['Male', 'Female'],
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
                    hintText: '+20 1280727589',
                    keyboardType: TextInputType.phone,
                    title: 'Phone Number',
                    controller: phoneNumberController,
                    validator: AppValidations.phoneNumberValidator,
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    icon: Icons.email,
                    hintText: 'keroles@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    title: 'Email Address',
                    controller: emailController,
                    validator: AppValidations.emailValidator,
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    isPasswordField: true,
                    icon: Icons.lock,
                    hintText: '*************',
                    title: 'Password',
                    controller: passwordController,
                    validator: (value) =>
                        AppValidations.passwordValidator(value: value),
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    isPasswordField: true,
                    icon: Icons.lock,
                    hintText: '*************',
                    title: 'Confirm Password',
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
                          'I agree to the Terms of Service and Privacy Policy',
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
                                const SnackBar(
                                  content: Text('Please agree to the terms'),
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
                              yearsOfExperience: null,
                              clinicAddress: null,
                              bio: null,
                              profilePictureUrl: null,
                            );

                            context.read<AuthCubit>().register(doctor: doctor);
                          },
                    title: isLoading ? 'Signing Up...' : 'Sign Up',
                    titleColor: ColorManager.white,
                    bgColor: ColorManager.primary,
                    width: width,
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
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
                          ' Log in',
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
