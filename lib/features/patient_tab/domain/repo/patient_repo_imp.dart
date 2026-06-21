import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/patient_tab/data/data_source/patient_remote_data_source.dart';
import 'package:clinc_dashboard/features/patient_tab/data/mapper/patient_model_mapper.dart';
import 'package:clinc_dashboard/features/patient_tab/data/repo/patient_repo.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';
import 'package:dartz/dartz.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource remoteDataSource;

  PatientRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<PatientEntity>>> getPatients({
    String? name,
    int? pageIndex,
  }) async {
    try {
      final models = await remoteDataSource.getPatients(
        name: name,
        pageIndex: pageIndex,
      );
      return Right(models.map((model) => model.toEntity).toList());
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalPatientsNumber({
    required String? name,
  }) async {
    try {
      final numberOfPatients = await remoteDataSource.getTotalPatientsNumber(
        name: name,
      );
      return Right(numberOfPatients);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
