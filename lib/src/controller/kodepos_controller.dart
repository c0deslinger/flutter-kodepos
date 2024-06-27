import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../model/item_address_value.dart';

/// Enum representing the state of address data loading.
enum AddressDataState { init, loading, loaded, error }

/// Controller for managing address data such as provinces, cities, districts, and subdistricts.
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

  /// Resets the selected address data and clears the controllers.
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

  /// Fetches the list of provinces from a CSV file.
  ///
  /// [printDebug] if true, prints the number of provinces loaded.
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

  /// Fetches the list of cities for a given province from a CSV file.
  ///
  /// [provinceId] the ID of the province.
  /// [printDebug] if true, prints the number of cities loaded.
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

  /// Fetches the list of districts for a given city from a CSV file.
  ///
  /// [cityId] the ID of the city.
  /// [printDebug] if true, prints the number of districts loaded.
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

  /// Fetches the list of subdistricts for a given district from a CSV file.
  ///
  /// [districtId] the ID of the district.
  /// [printDebug] if true, prints the number of subdistricts loaded.
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

  /// Fetches the postal code for a given city, district, and subdistrict from a CSV file.
  ///
  /// [cityId] the ID of the city.
  /// [districtId] the ID of the district.
  /// [subdistrictId] the ID of the subdistrict.
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

  /// Checks and sets the selected address data at the start.
  ///
  /// [selectedProvince] the selected province.
  /// [selectedCity] the selected city.
  /// [selectedDistrict] the selected district.
  /// [selectedSubdistrict] the selected subdistrict.
  void checkSelectedAtFirst({
    ItemAddressValue? selectedProvince,
    ItemAddressValue? selectedCity,
    ItemAddressValue? selectedDistrict,
    ItemAddressValue? selectedSubdistrict,
  }) {
    Future.delayed(const Duration(milliseconds: 100), () {
      this.selectedProvince = selectedProvince;
      provinceController.text = selectedProvince?.name ?? "";
      this.selectedCity = selectedCity;
      cityController.text = selectedCity?.name ?? "";
      this.selectedDistrict = selectedDistrict;
      districtController.text = selectedDistrict?.name ?? "";
      this.selectedSubdistrict = selectedSubdistrict;
      subdistrictController.text = selectedSubdistrict?.name ?? "";
      update();
    });
  }
}
