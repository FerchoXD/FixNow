import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final supplierData = SupplierData();
  return HomeNotifier(supplierData: supplierData);
});

class HomeState {
  final List<Supplier> suppliers;
  final bool isLoading;

  const HomeState({this.suppliers = const [], this.isLoading = true});

  HomeState copyWith({
    List<Supplier>? suppliers,
    bool? isLoading,
  }) =>
      HomeState(
        suppliers: suppliers ?? this.suppliers,
        isLoading: isLoading ?? this.isLoading,
      );
}

class HomeNotifier extends StateNotifier<HomeState> {
  final SupplierData supplierData;
  HomeNotifier({required this.supplierData}) : super(const HomeState()) {
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
}
