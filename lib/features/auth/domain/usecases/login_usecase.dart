import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/get_it/get_it.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/auth/data/models/login_request.dart';
import 'package:julybyoma_app/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase implements UseCase<Either, LoginRequest> {
  @override
  Future<Either> call({LoginRequest? param}) async {
    return getIt<AuthRepository>().login(param!);
  }
}
