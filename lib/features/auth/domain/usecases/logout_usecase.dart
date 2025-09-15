import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/auth/domain/repository/auth_repository.dart';
import 'package:julybyoma_app/injection.dart';

class LogoutUseCase extends UseCase<void, dynamic> {
  @override
  Future<Either<String, void>> call({dynamic param}) async {
    try {
      await getIt<AuthRepository>().logout();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
