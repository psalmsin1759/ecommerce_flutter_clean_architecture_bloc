import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/auth/data/models/signup_request.dart';
import 'package:julybyoma_app/features/auth/domain/repository/auth_repository.dart';

class SignupUseCase implements UseCase<Either, SignupRequest> {
  @override
  Future<Either> call({SignupRequest? param}) async {
    return getIt<AuthRepository>().signUp(param!);
  }
}
