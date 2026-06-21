import 'package:clinc_dashboard/features/dashboard_tab/data/models/appointment_model.dart';

abstract class AppointmentRemoteDataSource {
  Future<List<AppointmentModel>> getAppointments({int? status});

  Future<void> updateAppointmentType({
    required int appointmentId,
    required int newStatus,
  });
}
