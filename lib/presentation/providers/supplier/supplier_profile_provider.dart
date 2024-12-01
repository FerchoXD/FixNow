import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/infrastructure/services/key_value_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supplierProfileProvider = StateNotifierProvider.autoDispose
    .family<SupplierProfileNotifier, SupplierProfileState, String>(
        (ref, supplierId) {
  final supplierData = SupplierData();
  final keyValueStorage = KeyValueStorage();
  return SupplierProfileNotifier(
      supplierData: supplierData,
      keyValueStorage: keyValueStorage,
      id: supplierId);
});

class SupplierProfileState {
  final String id;
  final Supplier? supplier;
  final bool isLoading;

  const SupplierProfileState(
      {required this.id, this.supplier, this.isLoading = true});

  SupplierProfileState copyWith({
    String? id,
    Supplier? supplier,
    bool? isLoading,
  }) =>
      SupplierProfileState(
        id: id ?? this.id,
        supplier: supplier ?? this.supplier,
        isLoading: isLoading ?? this.isLoading,
      );
}

class SupplierProfileNotifier extends StateNotifier<SupplierProfileState> {
  final SupplierData supplierData;
  final KeyValueStorage keyValueStorage;
  SupplierProfileNotifier(
      {required this.supplierData,
      required this.keyValueStorage,
      required String id})
      : super(SupplierProfileState(id: id)) {
    getProfileData();
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
}
