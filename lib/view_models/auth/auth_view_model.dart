import 'package:counter_app/models/user_model.dart';
import 'package:counter_app/services/auth_service.dart';
import 'package:counter_app/view_models/auth/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthService _service;

  AuthViewModel(this._service) : super(const AuthState()) {
    loadSession();
  }

  Future<void> loadSession() async {
  state = state.copyWith(loading: true, error: null);

  final user = await _service.getCurrentUser();

  if (user == null) {
    state = state.copyWith(user: null, loading: false);
  } else {
    state = state.copyWith(user: user, loading: false);
  }
}



  Future<bool> signup(String email, String password, {String? name}) async {
    state = state.copyWith(loading: true, error: null);
    final result = await _service.registerUser(
      UserModel(email: email, password: password, name: name),
    );
    state = state.copyWith(loading: false);
    if (!result) {
      state = state.copyWith(error: 'Email already registered');
    }
    return result;
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(loading: true, error: null);
    final user = await _service.authenticate(email, password);
    if (user != null) {
      await _service.setCurrentUser(user.email!);
      state = state.copyWith(user: user, loading: false);
      return true;
    } else {
      state = state.copyWith(
        loading: false,
        error: 'Invalid email or password',
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _service.logout();
    state = state.copyWith(user: null, loading: false);
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthViewModel(service);
});
