import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../model/item_address_value.dart';

class AddressController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    listOfProvince();
  }

  Future<void> listOfProvince() async {
    try {
      String csvString = await rootBundle
          .loadString('packages/kodepos/assets/csv/province.csv');
      List<String> csvList = csvString.split('\n');
      for (var element in csvList) {
        if (element.isEmpty || element.contains("_id")) continue;
        List<String> row = element.split(',');
        provinces.add(ItemAddressValue(row[0], row[1]));
      }
      debugPrint('Provinces: ${provinces.length}');
      update();
    } catch (e) {
      debugPrint('Error loading provinces: $e');
    }
  }

  Future<void> listOfCity(String provinceId) async {
    try {
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
      debugPrint('Cities: ${city.length}');
      update();
    } catch (e) {
      debugPrint('Error loading cities: $e');
    }
  }

  Future<void> listOfDistrict(String cityId) async {
    try {
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
      debugPrint('District: ${district.length}');
      update();
    } catch (e) {
      debugPrint('Error loading district: $e');
    }
  }

  Future<void> listOfSubdistrict(String districtId) async {
    try {
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
      debugPrint('SubDistrict: ${district.length}');
      update();
    } catch (e) {
      debugPrint('Error loading subdistrict: $e');
    }
  }

  Future<String?> getPostalCode() async {
    try {
      String csvString = await rootBundle.loadString(
          'packages/kodepos/assets/csv/postal/postal_${selectedCity!.id}.csv');
      List<String> csvList = csvString.split('\n');
      String postalCode = "";
      for (var element in csvList) {
        if (element.isEmpty || element.contains("_id")) continue;
        List<String> row = element.split(',');
        if (row[1] == selectedSubdistrict!.id &&
            row[2] == selectedDistrict!.id) {
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
}
