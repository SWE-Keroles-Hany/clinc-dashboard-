import 'dart:developer';

import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_constants.dart';
import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/dio_services.dart';
import 'auth_remote_data_source.dart';

class AuthAPIDataSource implements AuthRemoteDataSource {
  final DioServices dioServices;

  AuthAPIDataSource(this.dioServices);
  @override
  Future<void> login({required String email, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final response = await dioServices.post(
        endPoint: ApiEndPoints.login,
        data: {"email": email, "password": password},
      );

      final token = response['token'];
      log("token by kero $token");
      await sharedPreferences.setString("token", token);
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.remove('token');
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> register({required DoctorModel doctor}) async {
    try {
      FormData formData = FormData.fromMap({
        "FullName": doctor.fullName,
        "Email": doctor.email,
        "Specialty": doctor.specialty,
        "YearsOfExperience": doctor.yearsOfExperience,
        "ClinicAddress": doctor.clinicAddress,
        "Password": doctor.password,
        "PhoneNumber": doctor.phoneNumber,
        "Gender": doctor.gender,
        "Bio": "doctor.bio",
        "LicenseNumber": "doctor.licenseNumber",
        "ProfilePicture": "doctor.licenseNumber",
      });

      await dioServices.post(endPoint: ApiEndPoints.register, data: formData);
    } on Failure catch (e) {
      log(e.message);
      throw Failure(message: e.message);
    }
  }

  @override
  Future<void> forgotPasswordSendCode({required String email}) async {
    try {
      await dioServices.post(
        queryParams: {"email": email},
        endPoint: ApiEndPoints.forgotPasswordSendCode,
      );
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> forgotPasswordVerifyCode({
    required String email,
    required String code,
  }) async {
    try {
      await dioServices.post(
        endPoint: ApiEndPoints.forgotPasswordVerifyCode,
        data: {"email": email, "code": code},
      );
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> forgotPasswordReset({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await dioServices.post(
        endPoint: ApiEndPoints.forgotPasswordReset,
        data: {
          "email": email,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
