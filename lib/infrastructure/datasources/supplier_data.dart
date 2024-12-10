import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/domain/mappers/contact_mapper.dart';
import 'package:fixnow/domain/mappers/supplier_mapper.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';

class SupplierData {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future sendBasicInformation(String id, String name, String lastName,
      String email, String phoneNumber, String address) async {
    try {
      FormData formData = FormData.fromMap({
        "uuid": id,
        "profileData[firstname]": name,
        "profileData[lastname]": lastName,
        "profileData[email]": email,
        "profileData[phone]": phoneNumber,
        "profileData[address]": address,
      });

      final response = await dio.put('/auth/profile/suplier', data: formData);
      final supplier = response.data['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendServicesData(String id, List<String> services) async {
    try {
      FormData formData = FormData.fromMap({
        "uuid": id,
        "profileData[selectedservices]": services,
      });

      final response = await dio.put('/auth/profile/suplier', data: formData);
      final supplier = response.data['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendExperience(String id, String experience) async {
    try {
      FormData formData = FormData.fromMap({
        "uuid": id,
        "profileData[workexperience]": experience,
      });

      final response = await dio.put('/auth/profile/suplier', data: formData);
      final supplier = response.data['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendPrices(String id, double standardPrice, double hourlyPrice) async {
    try {
      FormData formData = FormData.fromMap({
        "uuid": id,
        "profileData[standardprice]": standardPrice,
        "profileData[hourlyrate]": hourlyPrice,
      });

      final response = await dio.put('/auth/profile/suplier', data: formData);
      final supplier = response.data['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendCalendar(String id, List<Map<String, dynamic>> calendar) async {
    try {
      final calendarJson = jsonEncode(calendar);
      final formData = FormData.fromMap({
        'uuid': id,
        'calendar': calendarJson,
      });

      final response = await dio.put(
        '/auth/profile/suplier',
        data: formData,
      );
      // final supplier = UserMapper.contactJsonToEntity(response.data['data']['data']);
      final supplier = response.data['data']['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendImages(String id, List<File> images) async {
    try {
      FormData formData = FormData.fromMap({
        "uuid": id,
        "File": images.map((image) {
          return MultipartFile.fromFileSync(
            image.path,
            filename: image.path.split('/').last,
          );
        }).toList(),
      });

      final response = await dio.put(
        '/auth/profile/suplier',
        data: formData,
      );
      final supplier =
          UserMapper.contactJsonToEntity(response.data['data']['data']);
      return supplier;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['error']);
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['error']);
      }

      if (e.response?.statusCode == 404) {
        throw CustomError(e.response?.data['error']);
      }

      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['error'] ?? 'Error al obtener datos');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }

  Future<List<Supplier>> getAllSuppliers() async {
    try {
      final response =  await dio.post('/auth/all/suppliers', data: {"data": "All"});
      final List<Supplier> suppliers = [];
      for (final supplier in response.data ?? []) {
        suppliers.add(SupplierMapper.supplierJsonToEntity(supplier));
      }
      return suppliers;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.response?.statusCode == 404) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error al obtener datos');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }

  Future<Supplier> getSupplierById(String id, String token) async {
    try {
      final response = await dio.post('/auth/profile',
          options: Options(headers: {'Authorization': token}),
          data: {
            "uuid": id,
          });
      final supplier =
          SupplierMapper.supplierJsonToEntity(response.data['data']);
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future<List<Supplier>> getSuppliersByCategory(String category) async {
    try {
      final response =
          await dio.post('/auth/all/suppliers', data: {"data": category});

      final List<Supplier> suppliers = [];

      if (response.statusCode == 200) {
        if (response.data is List) {
          for (final supplier in response.data) {
            suppliers.add(SupplierMapper.supplierJsonToEntity(supplier));
          }
        } else {
          return [];
        }
      } else {
        throw CustomError('Error en la respuesta: ${response.statusCode}');
      }

      return suppliers;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message']);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error al obtener datos');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      print(e);
      throw CustomError('Algo pasó');
    }
  }

  Future<List<Supplier>> searchSupplier(String prompt, String token) async {
    try {
      final response = await dio.post('/auth/suppliers',
          data: {"prompt": prompt},
          options: Options(headers: {'Authorization': token}));

      final List<Supplier> suppliers = [];

      for (final supplier in response.data['suppliers'] ?? []) {
        suppliers.add(SupplierMapper.supplierJsonToEntity(supplier));
      }

      return suppliers;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['error']);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error al obtener datos');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      print(e);
      throw CustomError('Algo pasó');
    }
  }
}
