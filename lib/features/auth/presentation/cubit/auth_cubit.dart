// presentation/cubit/auth_cubit.dart
import 'package:clinc_dashboard/features/auth/domain/entities/doctor_entity.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_reset.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_send_code.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/forgot_password_verify_code.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/login.dart';
import 'package:clinc_dashboard/features/auth/domain/use_cases/register.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgotPasswordSendCodeUseCase forgotPasswordSendCodeUseCase;
  final ForgotPasswordVerifyCodeUseCase forgotPasswordVerifyCodeUseCase;
  final ForgotPasswordResetUseCase forgotPasswordResetUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgotPasswordSendCodeUseCase,
    required this.forgotPasswordVerifyCodeUseCase,
    required this.forgotPasswordResetUseCase,
  }) : super(LoginInitial());

  //! LOGIN
  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    final result = await loginUseCase(email: email, password: password);

    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (_) => emit(LoginSuccess()),
    );
  }

  //! REGISTER
  Future<void> register({required DoctorEntity doctor}) async {
    emit(RegisterLoading());

    final result = await registerUseCase(doctor: doctor);

    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (user) => emit(RegisterSuccess()),
    );
  }

  //! FORGOT PASSWORD - SEND CODE
  Future<void> forgotPasswordSendCode({required String email}) async {
    emit(ForgotPasswordSendCodeLoading());

    final result = await forgotPasswordSendCodeUseCase(email: email);

    result.fold(
      (failure) => emit(ForgotPasswordSendCodeError(failure.message)),
      (_) => emit(ForgotPasswordSendCodeSuccess()),
    );
  }

  //! FORGOT PASSWORD - VERIFY CODE
  Future<void> forgotPasswordVerifyCode({
    required String email,
    required String code,
  }) async {
    emit(ForgotPasswordVerifyCodeLoading());

    final result = await forgotPasswordVerifyCodeUseCase(
      email: email,
      code: code,
    );

    result.fold(
      (failure) => emit(ForgotPasswordVerifyCodeError(failure.message)),
      (_) => emit(ForgotPasswordVerifyCodeSuccess()),
    );
  }

  //! FORGOT PASSWORD - RESET PASSWORD
  Future<void> forgotPasswordReset({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ForgotPasswordResetLoading());

    final result = await forgotPasswordResetUseCase(
      email: email,
      code: code,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    result.fold(
      (failure) => emit(ForgotPasswordResetError(failure.message)),
      (_) => emit(ForgotPasswordResetSuccess()),
    );
  }
}
