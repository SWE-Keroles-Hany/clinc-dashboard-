import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'custom_input_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? isRemenderChecked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        decoration: BoxDecoration(color: ColorManager.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Back",
              style: AppTextStyles.s40bold.copyWith(color: ColorManager.black),
            ),
            Text(
              "Please Sign in to access your account",
              style: AppTextStyles.s18bold.copyWith(color: ColorManager.black),
            ),
            SizedBox(height: 30.h),

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

            SizedBox(height: 30.h),

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
            SizedBox(height: 3.h),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Forgot Password?",
                  style: AppTextStyles.s18bold.copyWith(
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  side: BorderSide(color: ColorManager.black),
                  checkColor: ColorManager.white,
                  activeColor: ColorManager.primary,
                  value: isRemenderChecked,
                  onChanged: (isChecked) {
                    setState(() {
                      isRemenderChecked = isChecked;
                    });
                  },
                ),
                Text(
                  "Remender me",
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
            SizedBox(height: 40.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("New To TeleMedidine? ", style: AppTextStyles.s20bold),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Create an Account",
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
    );
  }
}
