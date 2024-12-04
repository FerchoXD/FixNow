import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/infrastructure/datasources/auth_user.dart';
import 'package:fixnow/infrastructure/datasources/finances_data.dart';
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
  final authState = AuthState();

  return HomeNotifier(
      supplierData: supplierData,
      keyValueStorage: keyValueStorage,
      financesData: financesData,
      authState: authState);
});

class HomeState {
  final List<Supplier> suppliers;
  final bool isLoading;
  final String message;
  final String searchValue;
  final String sandBoxInitPoint;

  const HomeState(
      {this.suppliers = const [],
      this.isLoading = true,
      this.message = '',
      this.searchValue = '',
      this.sandBoxInitPoint = ''});

  HomeState copyWith({
    List<Supplier>? suppliers,
    bool? isLoading,
    String? message,
    String? searchValue,
    String? sandBoxInitPoint,
  }) =>
      HomeState(
          suppliers: suppliers ?? this.suppliers,
          isLoading: isLoading ?? this.isLoading,
          message: message ?? this.message,
          searchValue: searchValue ?? this.searchValue,
          sandBoxInitPoint: sandBoxInitPoint ?? this.sandBoxInitPoint);
}

class HomeNotifier extends StateNotifier<HomeState> {
  final SupplierData supplierData;
  final KeyValueStorage keyValueStorage;
  final FinancesData financesData;
  final AuthState authState;

  HomeNotifier(
      {required this.supplierData,
      required this.keyValueStorage,
      required this.financesData,
      required this.authState})
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
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  Future createSuscription(String userId) async {
    try {
      if (authState.user == null || authState.user!.id == null) {
        throw Exception('Usuario no autenticado o ID no disponible.');
      }

      final String newSuscription = await financesData.createSuscription(userId);
      state = state.copyWith(sandBoxInitPoint: newSuscription);
      Uri uri = Uri.parse(newSuscription);
      await _launchInBrowserView(uri);
    } on CustomError catch (e) {
      state = state.copyWith(message: e.message);
    }
  }
}

final selectedServiceProvider = StateProvider.autoDispose<String?>((ref) {
  return 'All';
});
