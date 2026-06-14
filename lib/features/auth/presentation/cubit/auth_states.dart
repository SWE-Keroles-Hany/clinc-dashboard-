// presentation/cubit/auth_state.dart

abstract class AuthState {}

// ----- LOGIN STATES -----
abstract class LoginState extends AuthState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess();
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

// ----- REGISTER STATES -----
abstract class RegisterState extends AuthState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterSuccess();
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}

// ----- FORGOT PASSWORD SEND CODE STATES -----
abstract class ForgotPasswordSendCodeState extends AuthState {}

class ForgotPasswordSendCodeInitial extends ForgotPasswordSendCodeState {}

class ForgotPasswordSendCodeLoading extends ForgotPasswordSendCodeState {}

class ForgotPasswordSendCodeSuccess extends ForgotPasswordSendCodeState {
  ForgotPasswordSendCodeSuccess();
}

class ForgotPasswordSendCodeError extends ForgotPasswordSendCodeState {
  final String message;

  ForgotPasswordSendCodeError(this.message);
}

// ----- FORGOT PASSWORD VERIFY CODE STATES -----
abstract class ForgotPasswordVerifyCodeState extends AuthState {}

class ForgotPasswordVerifyCodeInitial extends ForgotPasswordVerifyCodeState {}

class ForgotPasswordVerifyCodeLoading extends ForgotPasswordVerifyCodeState {}

class ForgotPasswordVerifyCodeSuccess extends ForgotPasswordVerifyCodeState {
  ForgotPasswordVerifyCodeSuccess();
}

class ForgotPasswordVerifyCodeError extends ForgotPasswordVerifyCodeState {
  final String message;

  ForgotPasswordVerifyCodeError(this.message);
}

// ----- FORGOT PASSWORD RESET STATES -----
abstract class ForgotPasswordResetState extends AuthState {}

class ForgotPasswordResetInitial extends ForgotPasswordResetState {}

class ForgotPasswordResetLoading extends ForgotPasswordResetState {}

class ForgotPasswordResetSuccess extends ForgotPasswordResetState {
  ForgotPasswordResetSuccess();
}

class ForgotPasswordResetError extends ForgotPasswordResetState {
  final String message;

  ForgotPasswordResetError(this.message);
}

// ----- LOGOUT STATES -----
abstract class LogoutState extends AuthState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutError extends LogoutState {
  final String message;

  LogoutError(this.message);
}
