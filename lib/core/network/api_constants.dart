class ApiEndPoints {
  static const String baseURL =
      "https://telemedicineapp20260326150133-cvdyaqbdcucsfmfh.uaenorth-01.azurewebsites.net/api/";
  static const String login = "Auth/login";
  static const String register = "Auth/RegisterDoctor";
  static const String forgotPasswordSendCode = "Auth/forgot-password";
  static const String forgotPasswordVerifyCode = "Auth/verify-code";
  static const String forgotPasswordReset = "Auth/reset-password";
  static const String dashboardStats = "Doctor/dashboard-stats";
  static const String appointments = "Doctor/appointments";
  static const String updateAppointmentStatus = "Doctor/update-status";
  static const String doctorProfile = "Doctor/profile";
  static const String updateDoctorImage = "Doctor/update-image";
  static const String myPatients = "Doctor/my-patients";
  static const String addMedicalRecord = "MedicalRecords/add-record";
  static const String setSchedule = "DoctorSchedules/set-schedule";
  static const String getWorkingDays = "DoctorSchedules/doctor";
}
