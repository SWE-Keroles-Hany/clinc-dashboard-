import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';

abstract class AppointmentState {
  final List<AppointmentEntity>? appointments;
  final int? selectedStatus;

  const AppointmentState({this.appointments, this.selectedStatus});
}

class AppointmentInitial extends AppointmentState {
  const AppointmentInitial();
}

class AppointmentLoading extends AppointmentState {
  const AppointmentLoading({super.appointments, super.selectedStatus});
}

class AppointmentSuccess extends AppointmentState {
  const AppointmentSuccess({
    required List<AppointmentEntity> appointments,
    super.selectedStatus,
  }) : super(appointments: appointments);
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(
    this.message, {
    super.appointments,
    super.selectedStatus,
  });
}

class AppointmentStatusUpdating extends AppointmentState {
  final int appointmentId;

  const AppointmentStatusUpdating({
    required this.appointmentId,
    super.appointments,
    super.selectedStatus,
  });
}

class AppointmentStatusUpdated extends AppointmentState {
  const AppointmentStatusUpdated({
    super.appointments,
    super.selectedStatus,
  });
}

class AppointmentStatusUpdateError extends AppointmentState {
  final String message;

  const AppointmentStatusUpdateError(
    this.message, {
    super.appointments,
    super.selectedStatus,
  });
}
