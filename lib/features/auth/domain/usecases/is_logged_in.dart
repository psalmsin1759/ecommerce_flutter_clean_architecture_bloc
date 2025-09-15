import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/auth/domain/repository/auth_repository.dart';

class IsLoggedInUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) {
    return getIt<AuthRepository>().isLoggedIn();
  }
}
