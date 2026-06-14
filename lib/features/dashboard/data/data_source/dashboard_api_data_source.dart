import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_constants.dart';
import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:clinc_dashboard/features/dashboard/data/models/appointment_model.dart';

class DashboardAPIDataSource implements DashboardRemoteDataSource {
  final DioServices dioServices;

  DashboardAPIDataSource(this.dioServices);

  @override
  Future<List<int>> getDashboardStatus() async {
    try {
      final response = await dioServices.get(
        endPoint: ApiEndPoints.dashboardStats,
      );

      final totalPatients = _toInt(response['totalPatients']);
      final todayAppointments = _toInt(response['todayAppointments']);
      final completedAppointments = _toInt(response['completedAppointments']);
      final cancelledAppointments = _toInt(
        response['cancelledAppointments'] ?? response['cacelledAppointments'],
      );
      final pendingAppointments = _toInt(
        response['pendingAppointments'],
        fallback:
            todayAppointments - completedAppointments - cancelledAppointments,
      );

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
      final response = await dioServices.get(
        endPoint: ApiEndPoints.appointments,
        queryParams: {'todayOnly': todayOnly},
      );

      final List<dynamic> rawList = response is List
          ? response
          : (response['data'] ?? response['appointments'] ?? []);

      return rawList
          .map(
            (item) => AppointmentModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  int _toInt(dynamic value, {int fallback = 0}) {
    if (value == null) return fallback;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? fallback;
  }
}
