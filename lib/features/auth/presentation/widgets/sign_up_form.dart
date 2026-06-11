import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/custom_button.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/blood_type_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'custom_input_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final specialtyController = TextEditingController();
  
  bool? isAgreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      decoration: BoxDecoration(color: ColorManager.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create Your Account",
            style: AppTextStyles.s40bold.copyWith(color: ColorManager.black),
          ),
          Text(
            "Secure access for medical practitioners",
            style: AppTextStyles.s18bold.copyWith(color: ColorManager.black),
          ),
           CustomInputField(
            icon: Icons.person,
            hintText: "Keorles Hany",
            keyboardType: TextInputType.text,
            title: "Full Name",
            controller: fullNameController,
            validator: (value) {
              return null;
            },
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
            Expanded(
              flex: 2,
              child: CustomInputField(
                  icon: Icons.medical_services_rounded,
                  hintText: "Dental",
                  keyboardType: TextInputType.text,
                  title: "Specialty",
                  controller: fullNameController,
                  validator: (value) {
                    return null;
                  },
                ),
            ),
            // Spacer(),
            SizedBox(width: 15.w,),
              Expanded(
                flex: 1,
                child: CustomDropDown(
                  label: "Gender",
                  onChanged: (value) {},
                  items: ["Male", "Female"],
                ),
              )
          ],),
           
    
         
         
          SizedBox(height: 20.h),
          CustomInputField(
            icon: Icons.phone,
            hintText: "+20 1280727589",
            keyboardType: TextInputType.number,
            title: "Phone Number",
            controller: phoneNumberController,
            validator: (value) {
              return null;
            },
          ),
          SizedBox(height: 20.h),
    
          CustomInputField(
            icon: Icons.email,
            hintText: "keroles@gmail.com",
            keyboardType: TextInputType.emailAddress,
            title: "Email Address",
            controller: emailController,
            validator: (value) {
              return null;
            },
          ),
          SizedBox(height: 20.h),
          CustomInputField(
            isPasswordField: true,
            icon: Icons.lock,
            hintText: "*************",
            title: "Password",
            controller: passwordController,
            validator: (value) {
              return null;
            },
          ),
          SizedBox(height: 20.h),
           CustomInputField(
            isPasswordField: true,
            icon: Icons.lock,
            hintText: "*************",
            title: "Confirm Password",
            controller: confirmPasswordController,
            validator: (value) {
              return null;
            },
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
                    isAgreedToTerms = isChecked;
                  });
                },
              ),
              Text(
                "I agree to the Terms of Service and Privacy Policy",
                style: AppTextStyles.s18bold.copyWith(
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
    
          CustomButton(
            onPressed: () {},
            title: "Sign Up",
            titleColor: ColorManager.white,
            bgColor: ColorManager.primary,
            width: width,
          ),
          SizedBox(height: 25.h),
    
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account ? ", style: AppTextStyles.s20bold),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
                child: Text(
                  "Log in",
                  style: AppTextStyles.s20bold.copyWith(
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
