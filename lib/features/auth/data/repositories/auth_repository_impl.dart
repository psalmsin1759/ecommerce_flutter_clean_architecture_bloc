import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/features/auth/data/models/login_request.dart';
import 'package:julybyoma_app/features/auth/data/models/signup_request.dart';
import 'package:julybyoma_app/features/auth/data/models/user_model.dart';
import 'package:julybyoma_app/features/auth/data/source/auth_api_service.dart';
import 'package:julybyoma_app/features/auth/data/source/auth_local_service.dart';
import 'package:julybyoma_app/features/auth/domain/entities/user_entity.dart';
import 'package:julybyoma_app/features/auth/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signUp(SignupRequest signUpRequest) async {
    final result = await getIt<AuthApiService>().signUp(signUpRequest);
    return result.fold((error) => Left(error), (data) async {
      final response = data as Response;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response.data["token"]);

      final user = UserModel.fromJson(response.data["user"]);
      await getIt<AuthLocalService>().saveUser(user);

      return Right(user);
    });
  }

  @override
  Future<Either> login(LoginRequest request) async {
    final result = await getIt<AuthApiService>().login(request);
    return result.fold((error) => Left(error), (data) async {
      final response = data as Response;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response.data["token"]);

      final user = UserModel.fromJson(response.data["user"]);
      await getIt<AuthLocalService>().saveUser(user);

      return Right(user);
    });
  }

  @override
  Future<bool> isLoggedIn() {
    return getIt<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<void> logout() {
    return getIt<AuthLocalService>().logout();
  }

  @override
  Future<void> saveUser(UserEntity userEntity) {
    final user = UserModel(
      id: userEntity.id,
      firstName: userEntity.firstName,
      lastName: userEntity.lastName,
      email: userEntity.email,
    );
    return getIt<AuthLocalService>().saveUser(user);
  }

  @override
  Future<Either> getUser() async {
    final user = await getIt<AuthLocalService>().getUser();
    if (user != null) {
      return Right(user);
    } else {
      return Left("No user found");
    }
  }
}
