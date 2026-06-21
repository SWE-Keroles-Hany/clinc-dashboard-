import 'dart:developer';

import 'package:clinc_dashboard/features/patient_tab/domain/use_cases/get_patients.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/use_cases/get_total_patients_number.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientState> {
  final GetPatientsUseCase getPatientsUseCase;
  final GetTotalPatientsNumberUseCase getTotalPatientsNumberUseCase;

  PatientCubit({
    required this.getPatientsUseCase,
    required this.getTotalPatientsNumberUseCase,
  }) : super(PatientInitial());
  int pageIndex = 1;

  Future<void> getPatients({bool inSearch = false, String? name}) async {
    emit(PatientLoading());
    if (inSearch) {
      pageIndex = 0;
    }
    final result = await getPatientsUseCase(name: name, pageIndex: pageIndex);

    result.fold((failure) => emit(PatientError(message: failure.message)), (
      patients,
    ) {
      emit(PatientSuccess(pageIndex: pageIndex, patients: patients));
    });
  }

  void nextPage({String? name}) {
    log("page $pageIndex");
    pageIndex++;
    getPatients(name: name);
  }

  void previousPage({String? name}) {
    log("page $pageIndex");

    if (pageIndex > 1) {
      pageIndex--;
      getPatients(name: name);
    }
  }

  Future<void> getTotalPatientsNumber({String? name}) async {
    final result = await getTotalPatientsNumberUseCase(name: name);

    result.fold((failure) => emit(PatientError(message: failure.message)), (
      value,
    ) {
      emit(PatientNumbersSuccess(numberOfpatients: value));
    });
  }
}
