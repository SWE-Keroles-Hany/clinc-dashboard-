import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_constants.dart';
import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/appointments_tab/data/data_source/appointment_remote_data_source.dart';
import 'package:clinc_dashboard/features/dashboard_tab/data/models/appointment_model.dart';

class AppointmentAPIDataSource implements AppointmentRemoteDataSource {
  final DioServices dioServices;

  AppointmentAPIDataSource(this.dioServices);

  @override
  Future<List<AppointmentModel>> getAppointments({
    int? status,
    String? selectedDate,
  }) async {
    try {
      final response = await dioServices.get(
        endPoint: ApiEndPoints.appointments,
        queryParams: {'selectedDate': selectedDate, 'status': status},
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

  @override
  Future<void> updateAppointmentType({
    required int appointmentId,
    required int newStatus,
  }) async {
    try {
      await dioServices.patch(
        endPoint: ApiEndPoints.updateAppointmentStatus,
        data: {'appointmentId': appointmentId, 'newStatus': newStatus},
      );
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
