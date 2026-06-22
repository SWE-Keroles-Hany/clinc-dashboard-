import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/appointments_tab/data/data_source/appointment_api_data_source.dart';
import 'package:clinc_dashboard/features/appointments_tab/domain/repo/appointment_repo_imp.dart';
import 'package:clinc_dashboard/features/appointments_tab/domain/use_cases/get_appointments.dart';
import 'package:clinc_dashboard/features/appointments_tab/domain/use_cases/update_appointment_type.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/cubit/appointment_cubit.dart';
import 'package:clinc_dashboard/features/auth/data/data_source/auth_api_data_source.dart';
import 'package:clinc_dashboard/features/auth/domain/repo/auth_repo_imp.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_reset.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_send_code.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_verify_code.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/login.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/logout.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/register.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/dashboard_tab/data/data_source/dashboard_api_data_source.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/repo/dashboard_repo_imp.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/use_cases/get_dashboard_status.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/use_cases/get_today_appointments.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/cubit/dashboard_cubit.dart';
import 'package:clinc_dashboard/features/patient_tab/data/data_source/patient_api_data_source.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/repo/patient_repo_imp.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/use_cases/add_medical_record.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/use_cases/get_patients.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/use_cases/get_total_patients_number.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_cubit.dart';
import 'package:clinc_dashboard/features/settings_tab/data/datasources/settings_local_datasource.dart';
import 'package:clinc_dashboard/features/settings_tab/data/datasources/settings_api_datasource.dart';
import 'package:clinc_dashboard/features/settings_tab/data/repositories/settings_repository_impl.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_profile_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/save_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/update_profile_image_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/update_profile_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core dependencies
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<DioServices>(DioServices(getIt<Dio>()));

  // Settings datasource and repository
  getIt.registerSingleton<SettingsLocalDataSource>(
    SettingsLocalDataSourceImpl(),
  );
  getIt.registerSingleton<SettingsAPIDataSource>(
    SettingsAPIDataSource(getIt<DioServices>()),
  );
  getIt.registerSingleton<SettingsRepositoryImpl>(
    SettingsRepositoryImpl(
      localDataSource: getIt<SettingsLocalDataSource>(),
      remoteDataSource: getIt<SettingsAPIDataSource>(),
    ),
  );

  // Settings usecases
  getIt.registerSingleton<GetLanguageUseCase>(
    GetLanguageUseCase(getIt<SettingsRepositoryImpl>()),
  );
  getIt.registerSingleton<SaveLanguageUseCase>(
    SaveLanguageUseCase(getIt<SettingsRepositoryImpl>()),
  );
  getIt.registerSingleton<GetProfileUseCase>(
    GetProfileUseCase(getIt<SettingsRepositoryImpl>()),
  );
  getIt.registerSingleton<UpdateProfileUseCase>(
    UpdateProfileUseCase(getIt<SettingsRepositoryImpl>()),
  );
  getIt.registerSingleton<UpdateProfileImageUseCase>(
    UpdateProfileImageUseCase(getIt<SettingsRepositoryImpl>()),
  );

  // Settings cubit
  getIt.registerFactory<SettingsCubit>(
    () => SettingsCubit(
      getLanguageUseCase: getIt<GetLanguageUseCase>(),
      saveLanguageUseCase: getIt<SaveLanguageUseCase>(),
      getProfileUseCase: getIt<GetProfileUseCase>(),
      updateProfileUseCase: getIt<UpdateProfileUseCase>(),
      updateProfileImageUseCase: getIt<UpdateProfileImageUseCase>(),
    ),
  );

  // Auth datasource and repository
  getIt.registerSingleton<AuthAPIDataSource>(
    AuthAPIDataSource(getIt<DioServices>()),
  );
  getIt.registerSingleton<AuthRepositoryImpl>(
    AuthRepositoryImpl(getIt<AuthAPIDataSource>()),
  );

  // Auth usecases
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerSingleton<LogoutUseCase>(
    LogoutUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerSingleton<ForgotPasswordSendCodeUseCase>(
    ForgotPasswordSendCodeUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerSingleton<ForgotPasswordVerifyCodeUseCase>(
    ForgotPasswordVerifyCodeUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerSingleton<ForgotPasswordResetUseCase>(
    ForgotPasswordResetUseCase(getIt<AuthRepositoryImpl>()),
  );

  // Auth cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      forgotPasswordSendCodeUseCase: getIt<ForgotPasswordSendCodeUseCase>(),
      forgotPasswordVerifyCodeUseCase: getIt<ForgotPasswordVerifyCodeUseCase>(),
      forgotPasswordResetUseCase: getIt<ForgotPasswordResetUseCase>(),
    ),
  );

  // Patient datasource and repository
  getIt.registerSingleton<PatientAPIDataSource>(
    PatientAPIDataSource(getIt<DioServices>()),
  );
  getIt.registerSingleton<PatientRepositoryImpl>(
    PatientRepositoryImpl(getIt<PatientAPIDataSource>()),
  );

  // Patient usecase
  getIt.registerSingleton<GetPatientsUseCase>(
    GetPatientsUseCase(getIt<PatientRepositoryImpl>()),
  );
  getIt.registerSingleton<GetTotalPatientsNumberUseCase>(
    GetTotalPatientsNumberUseCase(getIt<PatientRepositoryImpl>()),
  );
  getIt.registerSingleton<AddMedicalRecordUseCase>(
    AddMedicalRecordUseCase(getIt<PatientRepositoryImpl>()),
  );
  // Patient cubit
  getIt.registerFactory<PatientCubit>(
    () => PatientCubit(
      getTotalPatientsNumberUseCase: getIt<GetTotalPatientsNumberUseCase>(),
      getPatientsUseCase: getIt<GetPatientsUseCase>(),
      addMedicalRecordUseCase: getIt<AddMedicalRecordUseCase>(),
    ),
  );

  // Appointment datasource and repository
  getIt.registerSingleton<AppointmentAPIDataSource>(
    AppointmentAPIDataSource(getIt<DioServices>()),
  );
  getIt.registerSingleton<AppointmentRepositoryImpl>(
    AppointmentRepositoryImpl(getIt<AppointmentAPIDataSource>()),
  );

  // Appointment usecases
  getIt.registerSingleton<GetAppointmentsUseCase>(
    GetAppointmentsUseCase(getIt<AppointmentRepositoryImpl>()),
  );
  getIt.registerSingleton<UpdateAppointmentTypeUseCase>(
    UpdateAppointmentTypeUseCase(getIt<AppointmentRepositoryImpl>()),
  );

  // Appointment cubit
  getIt.registerFactory<AppointmentCubit>(
    () => AppointmentCubit(
      getAppointmentsUseCase: getIt<GetAppointmentsUseCase>(),
      updateAppointmentTypeUseCase: getIt<UpdateAppointmentTypeUseCase>(),
    ),
  );

  // Dashboard datasource and repository
  getIt.registerSingleton<DashboardAPIDataSource>(
    DashboardAPIDataSource(getIt<DioServices>()),
  );
  getIt.registerSingleton<DashboardRepositoryImpl>(
    DashboardRepositoryImpl(getIt<DashboardAPIDataSource>()),
  );

  // Dashboard usecases
  getIt.registerSingleton<GetDashboardStatusUseCase>(
    GetDashboardStatusUseCase(getIt<DashboardRepositoryImpl>()),
  );
  getIt.registerSingleton<GetTodayAppointmentsUseCase>(
    GetTodayAppointmentsUseCase(getIt<DashboardRepositoryImpl>()),
  );

  // Dashboard cubit
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(
      getDashboardStatusUseCase: getIt<GetDashboardStatusUseCase>(),
      getTodayAppointmentsUseCase: getIt<GetTodayAppointmentsUseCase>(),
    ),
  );
}
