import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/dashboard/data/repo/dashboard_repo.dart';
import 'package:dartz/dartz.dart';

class GetDashboardStatusUseCase {
  final DashboardRepository repository;

  GetDashboardStatusUseCase(this.repository);

  Future<Either<Failure, List<int>>> call() async {
    try {
      return await repository.getDashboardStatus();
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
