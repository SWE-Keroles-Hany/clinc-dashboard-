import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';

abstract class PatientState {}

class PatientInitial extends PatientState {}

class PatientLoading extends PatientState {}

class PatientSuccess extends PatientState {
  final List<PatientEntity> patients;
  PatientSuccess({required this.patients});
}

class PatientError extends PatientState {
  final String message;
  PatientError({required this.message});
}
