import 'package:get/get.dart';
import 'package:kodepos/src/controller/kodepos_controller.dart';
import 'package:kodepos/src/model/item_address_value.dart';

/// Kodepos mixin
/// Used to get data from kodepos
mixin KodeposMixin {
  KodeposController kodeposController =
      Get.put(KodeposController(), permanent: true);

  /// Get list of province
  /// Return list of province
  /// Example: List<ItemAddressValue>? provinces = await getListOfProvince();
  Future<List<ItemAddressValue>?> getListOfProvince() async {
    return kodeposController.listOfProvince();
  }

  /// Get list of city by provinceId
  /// Return list of city
  /// Example: List<ItemAddressValue>? cities = await getListOfCity(provinceId: "11");
  Future<List<ItemAddressValue>?> getListOfCity(
      {required String provinceId}) async {
    return kodeposController.listOfCity(provinceId);
  }

  /// Get list of district by cityId
  /// Return list of district
  /// Example: List<ItemAddressValue>? districts = await getListOfDistrict(cityId: "1101");
  Future<List<ItemAddressValue>?> getListOfDistrict(
      {required String cityId}) async {
    return kodeposController.listOfDistrict(cityId);
  }

  /// Get list of subdistrict by districtId
  /// Return list of subdistrict
  /// Example: List<ItemAddressValue>? subdistricts = await getListOfSubDistrict(districtId: "1101010");
  Future<List<ItemAddressValue>?> getListOfSubDistrict(
      {required String districtId}) async {
    return kodeposController.listOfSubdistrict(districtId);
  }

  /// Get postal code by cityId, districtId, and subdistrictId
  /// Return postal code
  /// Example: String? postalCode = await getPostalCode(cityId: "1101", districtId: "1101010", subdistrictId: "1101010001");
  Future<String?> getPostalCode(
      {required String cityId,
      required String districtId,
      required String subdistrictId}) async {
    return kodeposController.getPostalCode(cityId, districtId, subdistrictId);
  }
}
