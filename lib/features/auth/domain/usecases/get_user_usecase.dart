import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/auth/domain/repository/auth_repository.dart';

class GetUserUseCase implements UseCase<Either, void> {
  @override
  Future<Either> call({void param}) async {
    return getIt<AuthRepository>().getUser();
  }
}
