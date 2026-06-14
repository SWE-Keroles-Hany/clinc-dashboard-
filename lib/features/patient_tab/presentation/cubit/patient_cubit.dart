import 'package:clinc_dashboard/features/patient_tab/domain/use_cases/get_patients.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientState> {
  final GetPatientsUseCase getPatientsUseCase;

  PatientCubit({
    required this.getPatientsUseCase,
  }) : super(const PatientInitial());

  Future<void> getPatients() async {
    emit(
      PatientLoading(
        patients: state.patients,
        filteredPatients: state.filteredPatients,
        searchQueryParams: state.searchQueryParams,
      ),
    );

    final result = await getPatientsUseCase();

    result.fold(
      (failure) => emit(
        PatientError(
          failure.message,
          patients: state.patients,
          filteredPatients: state.filteredPatients,
          searchQueryParams: state.searchQueryParams,
        ),
      ),
      (patients) {
        // Apply existing search filter if present
        final query = state.searchQueryParams ?? "";
        final filtered = query.isEmpty
            ? patients
            : patients.where((p) {
                final matchName = p.fullName.toLowerCase().contains(query.toLowerCase());
                final matchId = p.patientId.toLowerCase().contains(query.toLowerCase());
                final matchPhone = p.phoneNumber.toLowerCase().contains(query.toLowerCase());
                return matchName || matchId || matchPhone;
              }).toList();

        emit(
          PatientSuccess(
            patients: patients,
            filteredPatients: filtered,
            searchQueryParams: query,
          ),
        );
      },
    );
  }

  void searchPatients(String query) {
    final patients = state.patients ?? [];
    if (patients.isEmpty) return;

    final filtered = query.isEmpty
        ? patients
        : patients.where((p) {
            final matchName = p.fullName.toLowerCase().contains(query.toLowerCase());
            final matchId = p.patientId.toLowerCase().contains(query.toLowerCase());
            final matchPhone = p.phoneNumber.toLowerCase().contains(query.toLowerCase());
            return matchName || matchId || matchPhone;
          }).toList();

    emit(
      PatientSuccess(
        patients: patients,
        filteredPatients: filtered,
        searchQueryParams: query,
      ),
    );
  }
}
