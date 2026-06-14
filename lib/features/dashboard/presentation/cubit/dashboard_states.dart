import 'package:clinc_dashboard/features/dashboard/domain/entities/appointment_entity.dart';

abstract class DashboardState {
  final List<int>? stats;
  final List<AppointmentEntity>? appointments;

  const DashboardState({this.stats, this.appointments});
}

class DashboardInitial extends DashboardState {
  const DashboardInitial() : super();
}

// ----- DASHBOARD STATS STATES -----
abstract class DashboardStatsState extends DashboardState {
  const DashboardStatsState({super.stats, super.appointments});
}

class DashboardStatsInitial extends DashboardStatsState {
  const DashboardStatsInitial({super.stats, super.appointments});
}

class DashboardStatsLoading extends DashboardStatsState {
  const DashboardStatsLoading({super.stats, super.appointments});
}

class DashboardStatsSuccess extends DashboardStatsState {
  const DashboardStatsSuccess({required List<int> stats, super.appointments})
    : super(stats: stats);
}

class DashboardStatsError extends DashboardStatsState {
  final String message;

  const DashboardStatsError(this.message, {super.stats, super.appointments});
}

// ----- APPOINTMENTS STATES -----
abstract class AppointmentsState extends DashboardState {
  const AppointmentsState({super.stats, super.appointments});
}

class AppointmentsInitial extends AppointmentsState {
  const AppointmentsInitial({super.stats, super.appointments});
}

class AppointmentsLoading extends AppointmentsState {
  const AppointmentsLoading({super.stats, super.appointments});
}

class AppointmentsSuccess extends AppointmentsState {
  const AppointmentsSuccess({
    required List<AppointmentEntity> appointments,
    super.stats,
  }) : super(appointments: appointments);
}

class AppointmentsError extends AppointmentsState {
  final String message;

  const AppointmentsError(this.message, {super.stats, super.appointments});
}
