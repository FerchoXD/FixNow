import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/infrastructure/inputs/hourly_rate.dart';
import 'package:fixnow/infrastructure/inputs/standar_price.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final pricesProvider = StateNotifierProvider<PriceNotifier, PricesState>((ref) {
  final supplierData = ProfileSupplierData();
  return PriceNotifier(supplierData: supplierData);
});

class PricesState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final StandarPrice standarPrice;
  final HourlyRate hourlyRate;
  final bool isCompleted;

  const PricesState(
      {this.standarPrice = const StandarPrice.pure(),
      this.hourlyRate = const HourlyRate.pure(),
      this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.isCompleted = false});

  PricesState copyWith({
    StandarPrice? standarPrice,
    HourlyRate? hourlyRate,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? isCompleted,
  }) =>
      PricesState(
          standarPrice: standarPrice ?? this.standarPrice,
          hourlyRate: hourlyRate ?? this.hourlyRate,
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          isCompleted: isCompleted ?? this.isCompleted);
}

class PriceNotifier extends StateNotifier<PricesState> {
  final ProfileSupplierData supplierData;
  PriceNotifier({required this.supplierData}) : super(const PricesState());

  onStandarPriceChanged(double value) {
    final newPrice = StandarPrice.dirty(value);
    state = state.copyWith(standarPrice: newPrice);
    print(newPrice);
  }

  onHourlyRateChanged(double value) {
    final newHourlyRate = HourlyRate.dirty(value);
    state = state.copyWith(hourlyRate: newHourlyRate);
    print(newHourlyRate);
  }

  onFormSubmit(String id) async {
    _touchEveryField();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);

    try {
      await supplierData.sendPrices(
          id, state.standarPrice.value, state.hourlyRate.value);
      state = state.copyWith(isCompleted: true);
    } catch (e) {
      throw Error();
    }
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final standardPrice = StandarPrice.dirty(state.standarPrice.value);
    final hourlyRate = HourlyRate.dirty(state.hourlyRate.value);
    state = state.copyWith(
        isFormPosted: true,
        standarPrice: standardPrice,
        hourlyRate: hourlyRate,
        isValid: Formz.validate([standardPrice, hourlyRate]));
  }
}
