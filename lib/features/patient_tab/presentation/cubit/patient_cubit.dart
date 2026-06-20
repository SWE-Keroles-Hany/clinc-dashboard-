import 'package:clinc_dashboard/features/patient_tab/domain/use_cases/get_patients.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientState> {
  final GetPatientsUseCase getPatientsUseCase;
  PatientCubit({required this.getPatientsUseCase}) : super(PatientInitial());
  Future<void> getPatients() async {
    emit(PatientLoading());

    final result = await getPatientsUseCase();

    result.fold((failure) => emit(PatientError(message: failure.message)), (
      patients,
    ) {
      emit(PatientSuccess(patients: patients));
    });
  }
}
