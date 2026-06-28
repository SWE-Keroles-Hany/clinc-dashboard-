import 'dart:developer';
import 'dart:typed_data';

import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_constants.dart';
import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/data/datasources/settings_remote_datasource.dart';
import 'package:clinc_dashboard/features/settings_tab/data/models/schedule_model.dart';
import 'package:dio/dio.dart';

class SettingsAPIDataSource implements SettingsRemoteDataSource {
  final DioServices dioServices;

  SettingsAPIDataSource(this.dioServices);

  @override
  Future<DoctorModel> getProfile() async {
    try {
      final response = await dioServices.get(
        endPoint: ApiEndPoints.doctorProfile,
      );
      log(response.toString());
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
  Future<void> updateProfileImage({
    Uint8List? prescriptionBytes,
    String? fileName,
  }) async {
    try {
      if (prescriptionBytes == null) {
        throw Failure(message: 'Image is required');
      }
      final formData = FormData.fromMap({
        'Image': MultipartFile.fromBytes(
          prescriptionBytes,
          filename: fileName ?? 'img.png',
        ),
      });

      await dioServices.put(
        endPoint: ApiEndPoints.updateDoctorImage,
        data: formData,
      );
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> setSchedule({required List<ScheduleModel> schedules}) async {
    try {
      final data = schedules.map((s) => s.toJson()).toList();
      await dioServices.post(endPoint: ApiEndPoints.setSchedule, data: data);
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  // @override
  // Future<List<ScheduleModel>> getWorkingDays({required int doctorId}) async {
  //   try {
  //     final formData = FormData.fromMap({'doctorId': doctorId});
  //     final List<dynamic> response = await dioServices.post(
  //       endPoint: ApiEndPoints.getWorkingDays,
  //       data: formData,
  //     );

  //     return response
  //         .map((json) => ScheduleModel.fromJson(json as Map<String, dynamic>))
  //         .toList();
  //   } on Failure catch (error) {
  //     throw Failure(message: error.message);
  //   } catch (e) {
  //     throw Failure(message: e.toString());
  //   }
  // }
}
