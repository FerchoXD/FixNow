import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/infrastructure/datasources/auth_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { checking, authenticated, notAuthenticated, newUserRegistred, accountActivated}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authUser = AuthUser();
  // final keyValueStorage = KeyValueStorage();

  return AuthNotifier(authUser: authUser);
});

class AuthState {
  final AuthStatus authStatus;
  final User? contact;
  final String message;

  AuthState(
      {this.authStatus = AuthStatus.checking, this.contact, this.message = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? contact,
    String? message,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        contact: contact ?? this.contact,
        message: message ?? this.message,
      );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUser authUser;
  // final KeyValueStorage keyValueStorage;

  AuthNotifier({required this.authUser}) : super(AuthState()) {
    // checkAuthStatus();
  }

  // Future<void> loginUser(String identifier, String password) async {
  //   try {
  //     final user = await authUser.login(identifier, password);
  //     _setLoggedUser(user);
  //   } on AuthError catch (error) {
  //     logout(error.message);
  //   } catch (error) {
  //     logout('Algó malo pasó');
  //   }
  // }

  void registerUser(String name, String lastName, String email,
      String phoneNumber, String password, String role) async {
    try {
      await authUser.register(name, lastName, email, phoneNumber, password, role);
      state = state.copyWith(authStatus: AuthStatus.newUserRegistred);
    } on Error catch (error) {
      print(error);
      // logout(error);
    } catch (error) {
      print(error); // logout('Algo malo pasó');
    }
    // state = state.copyWith(authStatus: AuthStatus.checking);
  }

  void activateAccount(String code) async {
    try {
      await authUser.activateAccount(code);
      state = state.copyWith(authStatus: AuthStatus.accountActivated);
    } catch (e) {
      print(e);
    }
  }

  // void checkAuthStatus() async {
  //   final token = await keyValueStorage.getValue<String>('token');
  //   if (token == null) return logout();
  //   try {
  //     final user = await authUser.checkAuthStatus(token);
  //     _setLoggedUser(user);
  //   } catch (error) {
  //     logout();
  //   }
  // }

  // _setLoggedUser(User user) async {
  //   await keyValueStorage.setValueKey('token', user.token);

  //   state = state.copyWith(
  //     user: user,
  //     authStatus: AuthStatus.authenticated,
  //     message: '',
  //   );
  // }

  // Future<void> logout([String? errorMessage]) async {
  //   await keyValueStorage.removeKey('token');

  //   state = state.copyWith(
  //       authStatus: AuthStatus.notAuthenticated,
  //       user: null,
  //       message: errorMessage);
  // }
}
