import 'package:clinc_dashboard/features/dashboard_tab/data/models/appointment_model.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';

extension AppointmentModelMapper on AppointmentModel {
  AppointmentEntity get toEntity => AppointmentEntity(
    imgURL: imgURL,
    appointmentId: appointmentId,
    patientName: patientName,
    appointmentDate: appointmentDate,
    status: status,
  );
}
