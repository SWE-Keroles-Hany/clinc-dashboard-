import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/domain/entities/doctor_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> register({required DoctorEntity doctor});

  Future<Either<Failure, void>> forgotPasswordSendCode({required String email});

  Future<Either<Failure, void>> forgotPasswordVerifyCode({
    required String email,
    required String code,
  });

  Future<Either<Failure, void>> forgotPasswordReset({
    required String email,
    required String newPassword,
    required String confirmPassword,
  });
}
