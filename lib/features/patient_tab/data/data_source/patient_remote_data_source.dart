import 'package:clinc_dashboard/features/patient_tab/data/models/patient_model.dart';

abstract class PatientRemoteDataSource {
  Future<List<PatientModel>> getPatients();
}
