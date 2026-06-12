// domain/usecases/forgot_password_verify_code.dart
import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/data/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordVerifyCodeUseCase {
  final AuthRepository repository;

  ForgotPasswordVerifyCodeUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String code,
  }) async {
    try {
      return await repository.forgotPasswordVerifyCode(
        email: email,
        code: code,
      );
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
