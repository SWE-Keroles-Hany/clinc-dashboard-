import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_constants.dart';
import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/patient_tab/data/data_source/patient_remote_data_source.dart';
import 'package:clinc_dashboard/features/patient_tab/data/models/patient_model.dart';

class PatientAPIDataSource implements PatientRemoteDataSource {
  final DioServices dioServices;

  PatientAPIDataSource(this.dioServices);

  @override
  Future<List<PatientModel>> getPatients() async {
    try {
      final List<dynamic> response = await dioServices.get(
        endPoint: ApiEndPoints.myPatients,
      );

      return response.map((item) => PatientModel.fromJson(item)).toList();
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
