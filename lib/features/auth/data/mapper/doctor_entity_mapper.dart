import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/auth/domain/entities/doctor_entity.dart';

extension DoctorEntityMapper on DoctorEntity {
  DoctorModel get toModel => DoctorModel(
    gender: gender,
    password: password,
    bio: bio,
    clinicAddress: clinicAddress,
    email: email,
    fullName: fullName,
    phoneNumber: phoneNumber,
    profilePictureUrl: profilePictureUrl,
    specialty: specialty,
    yearsOfExperience: yearsOfExperience,
  );
}
