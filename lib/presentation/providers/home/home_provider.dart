import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/infrastructure/services/key_value_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final keyValueStorage = KeyValueStorage();

  final supplierData = SupplierData();
  return HomeNotifier(
      supplierData: supplierData, keyValueStorage: keyValueStorage);
});

class HomeState {
  final List<Supplier> suppliers;
  final bool isLoading;
  final String message;
  final String searchValue;

  const HomeState(
      {this.suppliers = const [],
      this.isLoading = true,
      this.message = '',
      this.searchValue = ''});

  HomeState copyWith({
    List<Supplier>? suppliers,
    bool? isLoading,
    String? message,
    String? searchValue,
  }) =>
      HomeState(
          suppliers: suppliers ?? this.suppliers,
          isLoading: isLoading ?? this.isLoading,
          message: message ?? this.message,
          searchValue: searchValue ?? this.searchValue);
}

class HomeNotifier extends StateNotifier<HomeState> {
  final SupplierData supplierData;
  final KeyValueStorage keyValueStorage;

  HomeNotifier({required this.supplierData, required this.keyValueStorage})
      : super(const HomeState()) {
    getAllSuppliers();
  }

  Future<void> getAllSuppliers() async {
    try {
      final suppliers = await supplierData.getAllSuppliers();
      state = state.copyWith(suppliers: suppliers);
    } catch (e) {
      throw Error();
    }

    state = state.copyWith(isLoading: false);
  }

  Future<void> getServiceByCategory(String category) async {
    try {
      state = state.copyWith(isLoading: true);
      final suppliers = await supplierData.getSuppliersByCategory(category);
      state = state.copyWith(suppliers: suppliers);
      print(state.suppliers);
    } on CustomError catch (e) {
      print(e.message);
      state = state.copyWith(isLoading: false);
    }
    state = state.copyWith(isLoading: false);
  }

  onSearchValueChanged(String value) {
    print(value);
    state = state.copyWith(searchValue: value);
  }

  Future<void> searchSuppliers() async {
    try {
      state = state.copyWith(isLoading: true);

      final token = await keyValueStorage.getValue('token');
      if (token == null) return;
      final suppliers =
          await supplierData.searchSupplier(state.searchValue, token);
      state = state.copyWith(suppliers: suppliers);
    } on CustomError catch (e) {
      print(e.message);
      state = state.copyWith(isLoading: false);
    }
    state = state.copyWith(isLoading: false);
  }
}

final selectedServiceProvider = StateProvider<String?>((ref) {
  return 'All';
});
