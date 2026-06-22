import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';

abstract class PatientState {}

class PatientInitial extends PatientState {}

class PatientLoading extends PatientState {}

class PatientSuccess extends PatientState {
  final List<PatientEntity>? patients;
  int? numberOfpatients;

  int? pageIndex;

  PatientSuccess({this.patients, this.pageIndex, this.numberOfpatients});
}

class PatientError extends PatientState {
  final String message;

  PatientError({required this.message});
}

class PatientNumbersSuccess extends PatientState {
  int numberOfpatients;
  PatientNumbersSuccess({required this.numberOfpatients});
}

class PatientNumbersError extends PatientState {
  final String message;

  PatientNumbersError({required this.message});
}

class AddMedicalRecordLoading extends PatientState {}

class AddMedicalRecordSuccess extends PatientState {}

class AddMedicalRecordError extends PatientState {
  final String message;

  AddMedicalRecordError({required this.message});
}
