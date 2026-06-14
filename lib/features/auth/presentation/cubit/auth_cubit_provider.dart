import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/auth/data/data_source/auth_api_data_source.dart';
import 'package:clinc_dashboard/features/auth/domain/repo/auth_repo_imp.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_reset.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_send_code.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_verify_code.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/login.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/register.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dio/dio.dart';

AuthCubit createAuthCubit() {
  final dioServices = DioServices(Dio());
  final remoteDataSource = AuthAPIDataSource(dioServices);
  final repository = AuthRepositoryImpl(remoteDataSource);

  return AuthCubit(
    loginUseCase: LoginUseCase(repository),
    registerUseCase: RegisterUseCase(repository),
    forgotPasswordSendCodeUseCase: ForgotPasswordSendCodeUseCase(repository),
    forgotPasswordVerifyCodeUseCase: ForgotPasswordVerifyCodeUseCase(
      repository,
    ),
    forgotPasswordResetUseCase: ForgotPasswordResetUseCase(repository),
  );
}
