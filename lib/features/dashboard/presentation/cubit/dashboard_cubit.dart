import 'package:clinc_dashboard/features/dashboard/domain/use_cases/get_dashboard_status.dart';
import 'package:clinc_dashboard/features/dashboard/domain/use_cases/get_today_appointments.dart';
import 'package:clinc_dashboard/features/dashboard/presentation/cubit/dashboard_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardStatusUseCase getDashboardStatusUseCase;
  final GetTodayAppointmentsUseCase getTodayAppointmentsUseCase;

  DashboardCubit({
    required this.getDashboardStatusUseCase,
    required this.getTodayAppointmentsUseCase,
  }) : super(const DashboardInitial());

  Future<void> getDashboardStatus() async {
    emit(
      DashboardStatsLoading(
        stats: state.stats,
        appointments: state.appointments,
      ),
    );

    final result = await getDashboardStatusUseCase();

    result.fold(
      (failure) => emit(
        DashboardStatsError(
          failure.message,
          stats: state.stats,
          appointments: state.appointments,
        ),
      ),
      (stats) => emit(
        DashboardStatsSuccess(stats: stats, appointments: state.appointments),
      ),
    );
  }

  Future<void> getTodayAppointments({required bool todayOnly}) async {
    emit(
      AppointmentsLoading(stats: state.stats, appointments: state.appointments),
    );

    final result = await getTodayAppointmentsUseCase(todayOnly: todayOnly);

    result.fold(
      (failure) => emit(
        AppointmentsError(
          failure.message,
          stats: state.stats,
          appointments: state.appointments,
        ),
      ),
      (appointments) => emit(
        AppointmentsSuccess(appointments: appointments, stats: state.stats),
      ),
    );
  }
}
