import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/domain/entities/user_temp.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;
  UserTemp? _userTemp;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
      userTemp = state.userTemp;
    });
  }

  AuthStatus get authStatus => _authStatus;
  UserTemp? get userTemp => _userTemp;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  set userTemp(UserTemp? value) {
    _userTemp = value;
    notifyListeners();
  }  
  
}
