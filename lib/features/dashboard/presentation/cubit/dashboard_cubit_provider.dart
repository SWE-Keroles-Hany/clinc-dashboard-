import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/dashboard/data/data_source/dashboard_api_data_source.dart';
import 'package:clinc_dashboard/features/dashboard/domain/repo/dashboard_repo_imp.dart';
import 'package:clinc_dashboard/features/dashboard/domain/use_cases/get_dashboard_status.dart';
import 'package:clinc_dashboard/features/dashboard/domain/use_cases/get_today_appointments.dart';
import 'package:clinc_dashboard/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:dio/dio.dart';

DashboardCubit createDashboardCubit() {
  final dioServices = DioServices(Dio());
  final remoteDataSource = DashboardAPIDataSource(dioServices);
  final repository = DashboardRepositoryImpl(remoteDataSource);

  return DashboardCubit(
    getDashboardStatusUseCase: GetDashboardStatusUseCase(repository),
    getTodayAppointmentsUseCase: GetTodayAppointmentsUseCase(repository),
  );
}
