import 'package:clinc_dashboard/features/dashboard_tab/data/models/appointment_model.dart';

abstract class DashboardRemoteDataSource {
  Future<List<int>> getDashboardStatus();

  Future<List<AppointmentModel>> getTodayAppointments({
    required bool todayOnly,
  });
}
