class LoginRequest {
  final String email;
  final String? password;
  final String? socialLogin;

  LoginRequest({required this.email, this.password, this.socialLogin});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'sociallogin': socialLogin,
    };
  }
}
