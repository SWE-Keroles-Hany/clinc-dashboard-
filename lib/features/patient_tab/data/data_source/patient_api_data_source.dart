import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_constants.dart';
import 'package:clinc_dashboard/core/network/dio_services.dart';
import 'package:clinc_dashboard/features/patient_tab/data/data_source/patient_remote_data_source.dart';
import 'package:clinc_dashboard/features/patient_tab/data/models/patient_model.dart';

class PatientAPIDataSource implements PatientRemoteDataSource {
  final DioServices dioServices;

  PatientAPIDataSource(this.dioServices);

  @override
  Future<List<PatientModel>> getPatients({String? name, int? pageIndex}) async {
    try {
      final response = await dioServices.get(
        endPoint:
            "${ApiEndPoints.myPatients}/?pageIndex=$pageIndex&pageSize=8&name=$name",
      );
      final List<dynamic> patients = response["data"];
      return patients.map((item) => PatientModel.fromJson(item)).toList();
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<int> getTotalPatientsNumber({String? name}) async {
    try {
      final response = await dioServices.get(
        endPoint: "${ApiEndPoints.myPatients}/?name=$name",
      );
      final numberOfPatients = response["totalCount"];
      return numberOfPatients;
    } on Failure catch (error) {
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
