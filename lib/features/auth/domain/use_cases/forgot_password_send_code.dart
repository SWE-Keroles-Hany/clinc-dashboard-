// domain/usecases/forgot_password_send_code.dart
import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/data/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordSendCodeUseCase {
  final AuthRepository repository;

  ForgotPasswordSendCodeUseCase(this.repository);

  Future<Either<Failure, void>> call({required String email}) async {
    try {
      return await repository.forgotPasswordSendCode(email: email);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
