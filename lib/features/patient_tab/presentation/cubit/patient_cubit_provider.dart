import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/patient_tab/data/data_source/patient_api_data_source.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/repo/patient_repo_imp.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/use_cases/get_patients.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_cubit.dart';
import 'package:dio/dio.dart';

PatientCubit createPatientCubit() {
  final dioServices = DioServices(Dio());
  final remoteDataSource = PatientAPIDataSource(dioServices);
  final repository = PatientRepositoryImpl(remoteDataSource);

  return PatientCubit(
    getPatientsUseCase: GetPatientsUseCase(repository),
  );
}
