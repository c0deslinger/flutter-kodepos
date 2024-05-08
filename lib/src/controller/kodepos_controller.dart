import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../model/item_address_value.dart';

enum AddressDataState { init, loading, loaded, error }

class KodeposController extends GetxController {
  List<ItemAddressValue> provinces = [];
  List<ItemAddressValue> city = [];
  List<ItemAddressValue> district = [];
  List<ItemAddressValue> subdistrict = [];

  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController subdistrictController = TextEditingController();

  ItemAddressValue? selectedProvince;
  ItemAddressValue? selectedCity;
  ItemAddressValue? selectedDistrict;
  ItemAddressValue? selectedSubdistrict;

  String selectedPostalCode = "";

  AddressDataState provinceState = AddressDataState.init;
  AddressDataState cityState = AddressDataState.init;
  AddressDataState districtState = AddressDataState.init;
  AddressDataState subdistrictState = AddressDataState.init;

  @override
  void onInit() {
    super.onInit();
    listOfProvince();
  }

  void reset() {
    selectedCity = null;
    selectedDistrict = null;
    selectedProvince = null;
    selectedSubdistrict = null;
    selectedPostalCode = "";
    provinceController.clear();
    cityController.clear();
    districtController.clear();
    subdistrictController.clear();
    city.clear();
    district.clear();
    subdistrict.clear();
    update();
  }

  Future<List<ItemAddressValue>?> listOfProvince(
      {bool printDebug = false}) async {
    try {
      provinceState = AddressDataState.loading;
      update();
      String csvString = await rootBundle
          .loadString('packages/kodepos/assets/csv/province.csv');
      List<String> csvList = csvString.split('\n');
      for (var element in csvList) {
        if (element.isEmpty || element.contains("_id")) continue;
        List<String> row = element.split(',');
        provinces.add(ItemAddressValue(row[0], row[1]));
      }
      if (printDebug) {
        debugPrint('Provinces: ${provinces.length}');
      }
      provinceState = AddressDataState.loaded;
    } catch (e) {
      provinceState = AddressDataState.error;
      debugPrint('Error loading provinces: $e');
    }
    update();
    return provinces;
  }

  Future<List<ItemAddressValue>?> listOfCity(String provinceId,
      {bool printDebug = false}) async {
    try {
      cityState = AddressDataState.loading;
      update();
      String csvString =
          await rootBundle.loadString('packages/kodepos/assets/csv/city.csv');
      List<String> csvList = csvString.split('\n');
      city.clear();
      for (var element in csvList) {
        if (element.isEmpty || element.contains("_id")) continue;
        List<String> row = element.split(',');
        if (row[2] == provinceId) {
          city.add(ItemAddressValue(row[0], row[1]));
        }
      }
      if (printDebug) {
        debugPrint('City: ${city.length}');
      }
      cityState = AddressDataState.loaded;
    } catch (e) {
      debugPrint('Error loading cities: $e');
    }
    update();
    return city;
  }

  Future<List<ItemAddressValue>?> listOfDistrict(String cityId,
      {bool printDebug = false}) async {
    try {
      districtState = AddressDataState.loading;
      update();
      String csvString = await rootBundle
          .loadString('packages/kodepos/assets/csv/district.csv');
      List<String> csvList = csvString.split('\n');
      district.clear();
      for (var element in csvList) {
        if (element.isEmpty || element.contains("_id")) continue;
        List<String> row = element.split(',');
        if (row[2] == cityId) {
          district.add(ItemAddressValue(row[0], row[1]));
        }
      }
      if (printDebug) {
        debugPrint('District: ${district.length}');
      }
      districtState = AddressDataState.loaded;
    } catch (e) {
      debugPrint('Error loading district: $e');
    }
    update();
    return district;
  }

  Future<List<ItemAddressValue>?> listOfSubdistrict(String districtId,
      {bool printDebug = false}) async {
    try {
      subdistrictState = AddressDataState.loading;
      update();
      String csvString = await rootBundle.loadString(
          'packages/kodepos/assets/csv/subdis/subdis_$districtId.csv');
      List<String> csvList = csvString.split('\n');
      subdistrict.clear();
      for (var element in csvList) {
        if (element.isEmpty || element.contains("_id")) continue;
        List<String> row = element.split(',');
        if (row[2] == districtId) {
          subdistrict.add(ItemAddressValue(row[0], row[1]));
        }
      }
      if (printDebug) {
        debugPrint('SubDistrict: ${district.length}');
      }
      subdistrictState = AddressDataState.loaded;
    } catch (e) {
      debugPrint('Error loading subdistrict: $e');
    }
    update();
    return subdistrict;
  }

  Future<String?> getPostalCode(
      String cityId, String districtId, String subdistrictId) async {
    try {
      String csvString = await rootBundle
          .loadString('packages/kodepos/assets/csv/postal/postal_$cityId.csv');
      List<String> csvList = csvString.split('\n');
      String postalCode = "";
      for (var element in csvList) {
        if (element.isEmpty || element.contains("_id")) continue;
        List<String> row = element.split(',');
        if (row[1] == subdistrictId && row[2] == districtId) {
          postalCode = row[5];
          break;
        }
      }
      return postalCode;
    } catch (e) {
      debugPrint('Error get postal code: $e');
    }
    return null;
  }

  void checkSelectedAtFirst({
    ItemAddressValue? selectedProvince,
    ItemAddressValue? selectedCity,
    ItemAddressValue? selectedDistrict,
    ItemAddressValue? selectedSubdistrict,
  }) {
    Future.delayed(const Duration(milliseconds: 100), () {
      selectedProvince = selectedProvince;
      provinceController.text = selectedProvince?.name ?? "";
      selectedCity = selectedCity;
      cityController.text = selectedCity?.name ?? "";
      selectedDistrict = selectedDistrict;
      districtController.text = selectedDistrict?.name ?? "";
      selectedSubdistrict = selectedSubdistrict;
      subdistrictController.text = selectedSubdistrict?.name ?? "";
      update();
    });
  }
}
