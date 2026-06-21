import 'package:clinc_dashboard/features/appointments_tab/domain/use_cases/get_appointments.dart';
import 'package:clinc_dashboard/features/appointments_tab/domain/use_cases/update_appointment_type.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/cubit/appointment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final GetAppointmentsUseCase getAppointmentsUseCase;
  final UpdateAppointmentTypeUseCase updateAppointmentTypeUseCase;

  AppointmentCubit({
    required this.getAppointmentsUseCase,
    required this.updateAppointmentTypeUseCase,
  }) : super(const AppointmentInitial());

  Future<void> getAppointment({int? status}) async {
    emit(
      AppointmentLoading(
        appointments: state.appointments,
        selectedStatus: status,
      ),
    );

    final result = await getAppointmentsUseCase(status: status);

    result.fold(
      (failure) => emit(
        AppointmentError(
          failure.message,
          appointments: state.appointments,
          selectedStatus: status,
        ),
      ),
      (appointments) => emit(
        AppointmentSuccess(
          appointments: appointments,
          selectedStatus: status,
        ),
      ),
    );
  }

  Future<void> updateAppointmentType({
    required int appointmentId,
    required int newStatus,
  }) async {
    final selectedStatus = state.selectedStatus;
    final currentAppointments = state.appointments;

    emit(
      AppointmentStatusUpdating(
        appointmentId: appointmentId,
        appointments: currentAppointments,
        selectedStatus: selectedStatus,
      ),
    );

    final result = await updateAppointmentTypeUseCase(
      appointmentId: appointmentId,
      newStatus: newStatus,
    );

    result.fold(
      (failure) => emit(
        AppointmentStatusUpdateError(
          failure.message,
          appointments: currentAppointments,
          selectedStatus: selectedStatus,
        ),
      ),
      (_) async {
        emit(
          AppointmentStatusUpdated(
            appointments: currentAppointments,
            selectedStatus: selectedStatus,
          ),
        );
        await getAppointment(status: selectedStatus);
      },
    );
  }
}
