import 'dart:developer';

import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_constants.dart';
import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/dashboard_tab/data/data_source/dashboard_remote_data_source.dart';
import 'package:clinc_dashboard/features/dashboard_tab/data/models/appointment_model.dart';

class DashboardAPIDataSource implements DashboardRemoteDataSource {
  final DioServices dioServices;

  DashboardAPIDataSource(this.dioServices);

  @override
  Future<List<int>> getDashboardStatus() async {
    try {
      final response = await dioServices.get(
        endPoint: ApiEndPoints.dashboardStats,
      );

      final totalPatients = response['totalPatients'];
      final todayAppointments = response['todaysAppointments'];
      final completedAppointments = response['completedAppointments'];
      final cancelledAppointments = response['cancelledAppointments'];
      final pendingAppointments = response['pendingAppointments'];

      return [
        totalPatients,
        todayAppointments,
        completedAppointments,
        pendingAppointments,
        cancelledAppointments,
      ];
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<List<AppointmentModel>> getTodayAppointments({
    required bool todayOnly,
  }) async {
    try {
      final List<dynamic> response = await dioServices.get(
        endPoint: ApiEndPoints.appointments,
        queryParams: {'todayOnly': true, 'status': 2},
      );

      return response.map((item) => AppointmentModel.fromJson(item)).toList();
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      log("eror in today ${e.toString()}");
      throw Failure(message: e.toString());
    }
  }
}
