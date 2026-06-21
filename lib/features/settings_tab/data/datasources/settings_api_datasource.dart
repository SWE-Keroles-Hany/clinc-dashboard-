import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_constants.dart';
import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/data/datasources/settings_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SettingsAPIDataSource implements SettingsRemoteDataSource {
  final DioServices dioServices;

  SettingsAPIDataSource(this.dioServices);

  @override
  Future<DoctorModel> getProfile() async {
    try {
      final response = await dioServices.get(
        endPoint: ApiEndPoints.doctorProfile,
      );

      return DoctorModel.fromJson(response);
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> updateProfile({required DoctorModel doctor}) async {
    try {
      await dioServices.put(
        endPoint: ApiEndPoints.doctorProfile,
        data: doctor.toUpdateProfileJson(),
      );
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> updateProfileImage({String? profileImagePath}) async {
    try {
      final requestData = FormData.fromMap({'Image': profileImagePath});

      await dioServices.put(
        endPoint: ApiEndPoints.updateDoctorImage,
        data: requestData,
      );
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
