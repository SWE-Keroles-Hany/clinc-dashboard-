class AppointmentEntity {
  final int appointmentId;
  final String patientName;
  final String appointmentDate;
  final String status;
  final String? imgURL;

  const AppointmentEntity({
    required this.appointmentId,
    required this.patientName,
    required this.appointmentDate,
    required this.status,
    this.imgURL,
  });
}
