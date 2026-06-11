class ApiEndPoints {
  static const String baseURL =
      "https://telemedicineapp20260326150133-cvdyaqbdcucsfmfh.uaenorth-01.azurewebsites.net/api/";
  static const String login = "Auth/login";
  static const String registerPatient = "Auth/RegisterPatient";
  static const String bookDoctor = "Doctor/book";
  static const String doctors = "Doctor";
  static const String doctorsBySpecialty = "Doctor/get-by-Specialty";
  static const String specialties = "Doctor/specialties";
  static const String getDoctorByName = "Doctor/get-by-name";
  static const String myAppointments = "Patients/my-appointments";
  static const String topDoctors = "Doctor/top";
  static const String patientProfile = "Patients/profile";
  static const String updateProfile = "Patients/update-profile";
  static const String updateImage = "Patients/update-image";
  static const String logout = "Auth/logout";
  static const String changePassword = "Auth/change-password";
  static const String forgotPasswordSendCode = "Auth/forgot-password";
  static const String forgotPasswordVerifyCode = "Auth/verify-code";
  static const String forgotPasswordReset = "Auth/reset-password";
}
