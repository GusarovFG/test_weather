import 'package:bloc/bloc.dart';
import 'package:test_weather/data/services/firebase_service/firebase_auth_service/firebase_service.dart';
import 'package:test_weather/domain/models/user_model/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseService firebaseService = FirebaseService();
  bool isRegistration;

  AuthenticationBloc(this.isRegistration)
      : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUpUser>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user = isRegistration
            ? await firebaseService.onRegister(
                emailAddress: event.email, password: event.password)
            : await firebaseService.onLogin(
                emailAddress: event.email, password: event.password);
        if (user != null) {
          emit(AuthenticationSuccessState(user));
        } else {
          emit(const AuthenticationFailureState(
              'Некорректный email или пароль'));
        }
      } catch (e) {
        print(e.toString());
      }
    });

    on<SignOut>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        firebaseService.logOut();
      } catch (e) {
        print('error');
        print(e.toString());
      }
      emit(AuthenticationLoadingState(isLoading: false));
    });
  }
}
