import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesProvider =
    StateNotifierProvider<ServicesNotifier, ServicesState>((ref) {
  final supplierData = ProfileSupplierData();
  return ServicesNotifier(supplierData: supplierData);
});

class ServicesState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final List<String> services;

  const ServicesState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.services = const [],
  });

  ServicesState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    List<String>? services,
  }) =>
      ServicesState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        services: services ?? this.services,
      );
}

class ServicesNotifier extends StateNotifier<ServicesState> {
  final ProfileSupplierData supplierData;
  ServicesNotifier({required this.supplierData}) : super(const ServicesState());

  onServicesSelected(List<String> services) {
    state = state.copyWith(services: services);
  }

  onFormSubmit(String id) async {
    state = state.copyWith(isPosting: true);

    try {
      await supplierData.sendServicesData(id, state.services);
    } catch (e) {
      throw Error();
    }
        state = state.copyWith(isPosting: false);

  }
}
