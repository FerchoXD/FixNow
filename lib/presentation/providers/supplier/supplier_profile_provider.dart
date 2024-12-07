import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/infrastructure/datasources/raiting_data.dart';
import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/infrastructure/services/key_value_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supplierProfileProvider = StateNotifierProvider.autoDispose
    .family<SupplierProfileNotifier, SupplierProfileState, String>(
        (ref, supplierId) {
  final supplierData = SupplierData();
  final keyValueStorage = KeyValueStorage();
  final raitingData = RaitingData();
  return SupplierProfileNotifier(
      supplierData: supplierData,
      keyValueStorage: keyValueStorage,
      id: supplierId,
      raitingData: raitingData);
});

class SupplierProfileState {
  final String id;
  final Supplier? supplier;
  final bool isLoading;
  final List<Map<String, dynamic>> reviews;

  const SupplierProfileState(
      {required this.id,
      this.supplier,
      this.isLoading = true,
      this.reviews = const []});

  SupplierProfileState copyWith({
    String? id,
    Supplier? supplier,
    bool? isLoading,
    List<Map<String, dynamic>>? reviews,
  }) =>
      SupplierProfileState(
        id: id ?? this.id,
        supplier: supplier ?? this.supplier,
        isLoading: isLoading ?? this.isLoading,
        reviews: reviews ?? this.reviews,
      );
}

class SupplierProfileNotifier extends StateNotifier<SupplierProfileState> {
  final SupplierData supplierData;
  final KeyValueStorage keyValueStorage;
  final RaitingData raitingData;
  SupplierProfileNotifier(
      {required this.supplierData,
      required this.keyValueStorage,
      required String id,
      required this.raitingData})
      : super(SupplierProfileState(id: id)) {
    getProfileData();
    getReviews();
  }

  Future<void> getProfileData() async {
    try {
      final token = await keyValueStorage.getValue('token');
      if (token == null) return;
      final supplier = await supplierData.getSupplierById(state.id, token);
      state = state.copyWith(supplier: supplier);
    } catch (e) {
      state = state.copyWith(isLoading: false);

      throw Error();
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> getReviews() async {
    try {
      final reviews = await raitingData.getReviews(state.id);
      state = state.copyWith(reviews: reviews);
    } on CustomError catch (e) {
      state = state.copyWith(reviews: []);
    }
  }
}
