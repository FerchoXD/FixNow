import 'package:fixnow/infrastructure/inputs.dart';
import 'package:fixnow/presentation/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

enum CodeStatus { valid, notValid, checking }

class CodeState {
  final Code code;
  final CodeStatus codeStatus;
  final bool isValid;
  final bool isPosting;
  final bool isSent;
  final String message;

  CodeState(
      {this.code = const Code.pure(),
      this.codeStatus = CodeStatus.checking,
      this.isValid = false,
      this.isPosting = false,
      this.isSent = false,
      this.message = ''});

  CodeState copyWith({
    Code? code,
    CodeStatus? codeStatus,
    bool? isValid,
    bool? isPosting,
    bool? isSent,
    String? message,
  }) =>
      CodeState(
          code: code ?? this.code,
          codeStatus: codeStatus ?? this.codeStatus,
          isValid: isValid ?? this.isValid,
          isPosting: isPosting ?? this.isPosting,
          message: message ?? this.message);
}

class CodeNotifier extends StateNotifier<CodeState> {
  final Function(String) activateCallback;
  CodeNotifier({required this.activateCallback}) : super(CodeState());

  onCodeChanged(String value) {
    final newCode = Code.dirty(value);
    state = state.copyWith(code: newCode, isValid: Formz.validate([newCode]));
  }

  onCodeSubmit() async {
    final code = Code.dirty(state.code.value);
    state = state.copyWith(isSent: true, code: code, isValid: Formz.validate([code]));
    print(state.code.value);
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);
    try {
      await activateCallback(state.code.value);
    } catch (e) {
      print(e);
      state = state.copyWith(isPosting: false);
    }
    state = state.copyWith(isPosting: false);
  }
}

final codeProvider = StateNotifierProvider<CodeNotifier, CodeState>((ref) {
  final activateCallback = ref.watch(authProvider.notifier).activateAccount;
  return CodeNotifier(activateCallback: activateCallback);
});


