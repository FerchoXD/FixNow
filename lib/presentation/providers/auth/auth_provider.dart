import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/infrastructure/datasources/auth_user.dart';
import 'package:fixnow/infrastructure/services/key_value_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
  newUserRegistred,
  accountActivated
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authUser = AuthUser();
  final keyValueStorage = KeyValueStorage();

  return AuthNotifier(authUser: authUser, keyValueStorage: keyValueStorage);
});

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String message;
  final List userTemp;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.message = '',
      this.userTemp = const []});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? message,
    List? userTemp,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        message: message ?? this.message,
        userTemp: userTemp ?? this.userTemp,
      );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUser authUser;
  final KeyValueStorage keyValueStorage;

  AuthNotifier({required this.authUser, required this.keyValueStorage})
      : super(AuthState()) {
    // checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final userTemp = await authUser.login(email, password);
      // print(userTemp);
      _setLoggedUser(userTemp);
    } catch (error) {
      logout();
    }
  }

  void registerUser(String name, String lastName, String email,
      String phoneNumber, String password, String role) async {
    try {
      await authUser.register(
          name, lastName, email, phoneNumber, password, role);
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

  _setLoggedUser(userTemp) async {
    await keyValueStorage.setValueKey('token', userTemp['token']);
    state = state.copyWith(
      // user: user,
      // userTemp: userTemp,
      authStatus: AuthStatus.authenticated,
      message: '',
    );
  }

  Future<void> logout() async {
    // await authUser.logout(email);
    await keyValueStorage.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      // message: message);
    );
  }
}
