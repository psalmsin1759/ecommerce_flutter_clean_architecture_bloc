import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state.dart';

class UserStateCubit extends Cubit<UserState> {
  UserStateCubit() : super(UserInitial());

  Future<void> execute({dynamic params, required UseCase useCase}) async {
    emit(UserLoading());
    try {
      final result = await useCase.call(param: params);

      if (result is Either) {
        result.fold(
          (error) => emit(UserError(error.toString())),
          (user) => emit(UserLoaded(user as UserEntity)),
        );
      } else if (result is UserEntity) {
        emit(UserLoaded(result));
      } else {
        emit(UserError("Unexpected result type: ${result.runtimeType}"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
