import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/auth/domain/entities/doctor_entity.dart';

extension DoctorModelMapper on DoctorModel {
  DoctorEntity get toEntity => DoctorEntity(
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
