import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/auth/domain/entities/user_entity.dart';
import 'package:julybyoma_app/features/auth/domain/repository/auth_repository.dart';

class SaveUserUseCase implements UseCase<void, UserEntity> {
  @override
  Future<void> call({UserEntity? param}) async {
    return getIt<AuthRepository>().saveUser(param!);
  }
}
