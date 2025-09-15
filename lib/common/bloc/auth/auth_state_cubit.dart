import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/common/bloc/auth/auth_state.dart';
import 'package:julybyoma_app/core/get_it/get_it.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/is_logged_in.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await getIt<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
