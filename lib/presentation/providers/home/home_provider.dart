import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/infrastructure/datasources/finances_data.dart';
import 'package:fixnow/infrastructure/datasources/payments_data.dart';
import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/infrastructure/datasources/token_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/infrastructure/services/key_value_storage.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final keyValueStorage = KeyValueStorage();
  final token = TokenData();
  final supplierData = SupplierData();
  final financesData = FinancesData();
  final payments = PaymentsData();
  final authState = ref.watch(authProvider);

  return HomeNotifier(
      supplierData: supplierData,
      keyValueStorage: keyValueStorage,
      financesData: financesData,
      authState: authState,
      paymentsData: payments);
});

class HomeState {
  final List<Supplier> suppliers;
  final bool isLoading;
  final String message;
  final String searchValue;
  final String sandBoxInitPoint;
  final bool isLoadingPayment;

  const HomeState(
      {this.suppliers = const [],
      this.isLoading = true,
      this.message = '',
      this.searchValue = '',
      this.sandBoxInitPoint = '',
      this.isLoadingPayment = false});

  HomeState copyWith({
    List<Supplier>? suppliers,
    bool? isLoading,
    String? message,
    String? searchValue,
    String? sandBoxInitPoint,
    bool? isLoadingPayment,
  }) =>
      HomeState(
          suppliers: suppliers ?? this.suppliers,
          isLoading: isLoading ?? this.isLoading,
          message: message ?? this.message,
          searchValue: searchValue ?? this.searchValue,
          sandBoxInitPoint: sandBoxInitPoint ?? this.sandBoxInitPoint,
          isLoadingPayment: isLoadingPayment ?? this.isLoadingPayment);
}

class HomeNotifier extends StateNotifier<HomeState> {
  final SupplierData supplierData;
  final KeyValueStorage keyValueStorage;
  final FinancesData financesData;
  final AuthState authState;
  final PaymentsData paymentsData;

  HomeNotifier(
      {required this.supplierData,
      required this.keyValueStorage,
      required this.financesData,
      required this.authState,
      required this.paymentsData})
      : super(const HomeState()) {
    getAllSuppliers();
  }

  Future<void> getAllSuppliers() async {
    try {
      final suppliers = await supplierData.getAllSuppliers();
      state = state.copyWith(suppliers: suppliers);
    } on CustomError catch (e) {
      state = state.copyWith(suppliers: []);
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

  Future<void> _launchInBrowserView(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo abrir la URL: ${url.toString()}';
    }
  }

  Future createSuscription(String userId) async {
    try {
      state = state.copyWith(isLoadingPayment: true);
      final String newSuscription =
          await paymentsData.createSuscription(userId);
      state = state.copyWith(sandBoxInitPoint: newSuscription);
      Uri uri = Uri.parse(newSuscription);
      await _launchInBrowserView(uri);
    } on CustomError catch (e) {
      state = state.copyWith(isLoadingPayment: false);

      state = state.copyWith(message: e.message);
    }
    state = state.copyWith(isLoadingPayment: false);
  }
}

final selectedServiceProvider = StateProvider.autoDispose<String?>((ref) {
  return 'All';
});
