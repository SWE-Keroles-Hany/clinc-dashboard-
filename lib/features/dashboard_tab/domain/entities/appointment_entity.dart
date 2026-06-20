class AppointmentEntity {
  final int appointmentId;
  final String patientName;
  final String appointmentDate;
  final String status;

  const AppointmentEntity({
    required this.appointmentId,
    required this.patientName,
    required this.appointmentDate,
    required this.status,
  });
}
