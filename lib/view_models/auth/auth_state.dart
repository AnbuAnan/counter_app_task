
import 'package:counter_app/models/user_model.dart';

class AuthState {
  final UserModel? user;
  final bool loading;
  final String? error;

  const AuthState({this.user, this.loading = false, this.error});

  AuthState copyWith({UserModel? user, bool? loading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error ?? this.error
      );
  }
}
