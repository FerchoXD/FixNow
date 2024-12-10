import 'package:fixnow/infrastructure/datasources/raiting_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final raitingProvider =
    StateNotifierProvider.autoDispose<RaitingNotifier, RaitingState>((ref) {
  final raitingData = RaitingData();
  final userState = ref.watch(authProvider);
  return RaitingNotifier(raitingData: raitingData, authState: userState);
});

class RaitingState {
  final String review;
  final bool isSendinReview;
  final String message;
  final bool reviewPosted;
  final String status;

  const RaitingState(
      {this.review = '',
      this.isSendinReview = false,
      this.message = '',
      this.reviewPosted = false,
      this.status = ''});

  RaitingState copyWith({
    String? review,
    bool? isSendinReview,
    String? message,
    bool? reviewPosted,
    String? status,
  }) =>
      RaitingState(
          review: review ?? this.review,
          isSendinReview: isSendinReview ?? this.isSendinReview,
          message: message ?? this.message,
          reviewPosted: reviewPosted ?? this.reviewPosted,
          status: status ?? this.status);
}

class RaitingNotifier extends StateNotifier<RaitingState> {
  final RaitingData raitingData;
  final AuthState authState;
  RaitingNotifier({required this.raitingData, required this.authState})
      : super(const RaitingState());

  onReviewChanged(String value) {
    state = state.copyWith(review: value);
  }

  sendReview(String supplierId) async {
    if (state.review.isEmpty) return;
    try {
      state = state.copyWith(isSendinReview: true);
      final data =
          await raitingData.createReview(supplierId, state.review);
      state = state.copyWith(
          isSendinReview: false,
          message: data['message'],
          reviewPosted: true,
          status: data['status']);
    } on CustomError catch (e) {
      state = state.copyWith(
          message: e.message,
          isSendinReview: false,
          reviewPosted: true,
          status: '');
    }

    Future.delayed(const Duration(seconds: 3), () {
      state = const RaitingState();
    });
  }
}
