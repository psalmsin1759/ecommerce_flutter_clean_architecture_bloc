import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:julybyoma_app/core/constants/api_urls.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/core/network/dio_client.dart';
import 'package:julybyoma_app/features/auth/data/models/login_request.dart';
import 'package:julybyoma_app/features/auth/data/models/signup_request.dart';

abstract class AuthApiService {
  Future<Either> signUp(SignupRequest signUpRequest);
  Future<Either> login(LoginRequest request);
}

class AuthApServiceImpl extends AuthApiService {
  @override
  Future<Either> signUp(SignupRequest signUpRequest) async {
    try {
      var response = await getIt<DioClient>().post(
        ApiUrls.signUpURL,
        data: signUpRequest.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data["error"]);
    }
  }

  @override
  Future<Either> login(LoginRequest request) async {
    try {
      var response = await getIt<DioClient>().post(
        ApiUrls.loginURL,
        data: request.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data["error"]);
    }
  }
}
