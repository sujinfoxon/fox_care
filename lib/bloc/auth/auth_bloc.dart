import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxcare_app/repository/auth_repository.dart';
import 'package:meta/meta.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  void _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithEmailPassword(event.email, event.password);
      if (user != null) {
        final role = await authRepository.getUserRole(user.uid);
        emit(AuthAuthenticated(role: role!));
      } else {
        emit(AuthError('Authentication failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(AuthUnauthenticated());
  }
}
