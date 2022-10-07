import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit() : super(const LoginScreenState(isSwiped: false));

  void isSwiped() => emit(const LoginScreenState(isSwiped: true));
}
