// domain/usecases/forgot_password_reset.dart
import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/data/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordResetUseCase {
  final AuthRepository repository;

  ForgotPasswordResetUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      return await repository.forgotPasswordReset(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
