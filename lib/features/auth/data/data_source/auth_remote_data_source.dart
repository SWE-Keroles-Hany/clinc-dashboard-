import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> login({required String email, required String password});

  Future<void> register({required DoctorModel doctor});

  Future<void> forgotPasswordSendCode({required String email});

  Future<void> forgotPasswordVerifyCode({
    required String email,
    required String code,
  });

  Future<void> forgotPasswordReset({
    required String email,
    required String newPassword,
    required String confirmPassword,
  });
}
