import "package:dartz/dartz.dart";
import "package:julybyoma_app/features/auth/data/models/login_request.dart";
import "package:julybyoma_app/features/auth/data/models/signup_request.dart";
import "package:julybyoma_app/features/auth/domain/entities/user_entity.dart";

abstract class AuthRepository {
  Future<Either> signUp(SignupRequest signUpRequest);
  Future<Either> login(LoginRequest request);
  Future<bool> isLoggedIn();
  Future logout();

  Future<void> saveUser(UserEntity userEntity);
  Future<Either> getUser();
}
