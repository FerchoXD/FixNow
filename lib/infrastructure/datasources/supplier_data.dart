import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/domain/mappers/contact_mapper.dart';
import 'package:fixnow/domain/mappers/supplier_mapper.dart';

class ProfileSupplierData {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future registerSupplier() async {}

  Future sendBasicInformation(String id, String name, String lastName,
      String email, String phoneNumber, String address) async {
    try {
      final response = await dio.put('/auth/profile/suplier', data: {
        "uuid": id,
        "profileData": {
          "firstname": name,
          "lastname": lastName,
          "address": address,
          "phone": phoneNumber
        }
      });
      final supplier = response.data['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendServicesData(String id, List<String> services) async {
    try {
      final response = await dio.put('/auth/profile/suplier', data: {
        "uuid": id,
        "profileData": {"selectedservices": services}
      });
      final supplier = response.data['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendExperience(String id, String experience) async {
    try {
      final response = await dio.put('/auth/profile/suplier', data: {
        "uuid": id,
        "profileData": {"workexperience": experience}
      });
      final supplier = response.data['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendPrices(String id, double standardPrice, double hourlyPrice) async {
    try {
      final response = await dio.put('/auth/profile/suplier', data: {
        "uuid": id,
        "profileData": {
          "standardprice": standardPrice,
          "hourlyrate": hourlyPrice
        }
      });
      final supplier = response.data['data'];
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendCalendar(String id, List<Map<String, dynamic>> calendar) async {
    try {
      final response = await dio.put('/auth/profile/suplier',
          data: {"uuid": id, "calendar": calendar});
      final supplier = UserMapper.contactJsonToEntity(response.data['data']);
      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  Future sendImages(String id, List<String> images) async {
    try {
      final response = await dio
          .put('/auth/profile/suplier', data: {"uuid": id, "images": images});
      final supplier = UserMapper.contactJsonToEntity(response.data['data']);

      return supplier;
    } catch (e) {
      throw Error();
    }
  }

  // Future<Supplier> getSupplierInfo(String id, String token) async {
  //   try {
  //     final response = await dio.put('/auth/profile/suplier',
  //         options: Options(headers: {'Authorization': token}),
  //         data: {
  //           "uuid": id,
  //         });
  //     final supplier = SupplierMapper.supplierJsonToEntity(response.data['data']);
  //     return supplier;
  //   } catch (e) {
  //     throw Error();
  //   }
  // }
}
