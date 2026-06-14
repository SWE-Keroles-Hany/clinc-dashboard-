import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';

abstract class PatientState {
  final List<PatientEntity>? patients;
  final List<PatientEntity>? filteredPatients;
  final String? searchQueryParams;

  const PatientState({
    this.patients,
    this.filteredPatients,
    this.searchQueryParams,
  });
}

class PatientInitial extends PatientState {
  const PatientInitial() : super();
}

class PatientLoading extends PatientState {
  const PatientLoading({
    super.patients,
    super.filteredPatients,
    super.searchQueryParams,
  });
}

class PatientSuccess extends PatientState {
  const PatientSuccess({
    required List<PatientEntity> patients,
    required List<PatientEntity> filteredPatients,
    super.searchQueryParams,
  }) : super(patients: patients, filteredPatients: filteredPatients);
}

class PatientError extends PatientState {
  final String message;

  const PatientError(
    this.message, {
    super.patients,
    super.filteredPatients,
    super.searchQueryParams,
  });
}
