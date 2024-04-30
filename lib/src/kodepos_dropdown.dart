import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodepos/src/address_input_field.dart';
import 'package:kodepos/src/controller/address_controller.dart';
import 'package:kodepos/src/model/address_value.dart';

/// KodeposDropdown is a widget that provides a dropdown list of Indonesian provinces, cities, districts, and subdistricts.
/// It requires [AddressController] to manage the list of provinces, cities, districts, and subdistricts.
/// It also requires [AddressInputField] to display the dropdown list.
class KodeposDropdown extends StatefulWidget {
  final String? provinceTitle;
  final String? cityTitle;
  final String? districtTitle;
  final String? subdistrictTitle;
  final String? provinceHint;
  final String? cityHint;
  final String? districtHint;
  final String? subdistrictHint;
  final Function(AddressValue)? onCompleted;
  final Function? onProvinceReset;
  final Function? onCityReset;
  final Function? onDistrictReset;
  final Function? onSubdistrictReset;
  final Function? onItemReset;
  final double marginBottom;
  final Widget? inputPrefixWidget;
  final String? prefixDropdownLabelProvince;
  final String? prefixDropdownLabelCity;
  final String? prefixDropdownLabelDistrict;
  final String? prefixDropdownLabelSubdistrict;
  final InputDecoration? inputDecoration;
  final InputDecoration? selectedInputDecoration;
  final BoxDecoration? boxDecoration;
  final BoxDecoration? selectedBoxDecoration;
  final Widget? selectedPrefixWidgetProvince;
  final Widget? selectedPrefixWidgetCity;
  final Widget? selectedPrefixWidgetDistrict;
  final Widget? selectedPrefixWidgetSubdistrict;

  const KodeposDropdown(
      {super.key,
      this.provinceTitle,
      this.cityTitle,
      this.prefixDropdownLabelProvince,
      this.prefixDropdownLabelCity,
      this.prefixDropdownLabelDistrict,
      this.prefixDropdownLabelSubdistrict,
      this.districtTitle,
      this.subdistrictTitle,
      this.marginBottom = 16,
      this.inputPrefixWidget,
      this.provinceHint,
      this.cityHint,
      this.inputDecoration,
      this.selectedInputDecoration,
      this.districtHint,
      this.subdistrictHint,
      this.onProvinceReset,
      this.onCityReset,
      this.onDistrictReset,
      this.onSubdistrictReset,
      this.onItemReset,
      this.boxDecoration,
      this.selectedPrefixWidgetCity,
      this.selectedPrefixWidgetDistrict,
      this.selectedPrefixWidgetProvince,
      this.selectedPrefixWidgetSubdistrict,
      this.selectedBoxDecoration,
      this.onCompleted});

  @override
  State<KodeposDropdown> createState() => _KodeposDropdownState();
}

class _KodeposDropdownState extends State<KodeposDropdown> {
  @override
  void initState() {
    Get.put(AddressController(), permanent: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(builder: (addressController) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: widget.marginBottom),
            child: AddressInputField(
              title: widget.provinceTitle,
              prefixWidget: widget.inputPrefixWidget,
              prefixDropdownLabel: widget.prefixDropdownLabelProvince ?? "",
              hint: widget.provinceHint ?? "Cari nama provinsi",
              isAddressSelected: addressController.selectedProvince != null,
              addressList: addressController.provinces,
              addressController: addressController.provinceController,
              boxDecoration: widget.boxDecoration,
              boxDecorationSelected: widget.selectedBoxDecoration,
              selectedPrefixWidget: widget.selectedPrefixWidgetProvince,
              onSelected: (address) {
                debugPrint(address.name);
                addressController.listOfCity(address.id);
                addressController.selectedProvince = address;
                addressController.update();
              },
              inputDecoration: widget.inputDecoration,
              inputDecorationSelected: widget.selectedInputDecoration,
              onReset: () {
                addressController.selectedProvince = null;
                addressController.selectedCity = null;
                addressController.selectedDistrict = null;
                addressController.selectedSubdistrict = null;
                addressController.provinceController.text = "";
                addressController.cityController.text = "";
                addressController.districtController.text = "";
                addressController.subdistrictController.text = "";
                addressController.update();
                if (widget.onProvinceReset != null) {
                  widget.onProvinceReset!();
                }
                if (widget.onItemReset != null) {
                  widget.onItemReset!();
                }
              },
            ),
          ),
          if (addressController.selectedProvince != null)
            Container(
              margin: EdgeInsets.only(bottom: widget.marginBottom),
              child: AddressInputField(
                title: widget.cityTitle,
                hint: widget.cityHint ?? "Cari nama kota",
                isAddressSelected: addressController.selectedCity != null,
                addressList: addressController.city,
                addressController: addressController.cityController,
                prefixWidget: widget.inputPrefixWidget,
                prefixDropdownLabel: widget.prefixDropdownLabelCity ?? "",
                boxDecoration: widget.boxDecoration,
                boxDecorationSelected: widget.selectedBoxDecoration,
                selectedPrefixWidget: widget.selectedPrefixWidgetCity,
                onSelected: (address) {
                  addressController.selectedCity = address;
                  addressController.update();
                  debugPrint(address.name);
                  addressController.listOfDistrict(address.id);
                },
                onReset: () {
                  addressController.selectedCity = null;
                  addressController.selectedDistrict = null;
                  addressController.selectedSubdistrict = null;
                  addressController.cityController.text = "";
                  addressController.districtController.text = "";
                  addressController.subdistrictController.text = "";
                  addressController.update();
                  if (widget.onCityReset != null) {
                    widget.onCityReset!();
                  }

                  if (widget.onItemReset != null) {
                    widget.onItemReset!();
                  }
                },
              ),
            ),
          if (addressController.selectedCity != null)
            Container(
              margin: EdgeInsets.only(bottom: widget.marginBottom),
              child: AddressInputField(
                title: widget.districtTitle,
                hint: widget.districtHint ?? "Cari nama kecamatan",
                isAddressSelected: addressController.selectedDistrict != null,
                addressList: addressController.district,
                addressController: addressController.districtController,
                selectedPrefixWidget: widget.selectedPrefixWidgetDistrict,
                prefixDropdownLabel: widget.prefixDropdownLabelDistrict ?? "",
                prefixWidget: widget.inputPrefixWidget,
                boxDecoration: widget.boxDecoration,
                boxDecorationSelected: widget.selectedBoxDecoration,
                onSelected: (address) {
                  addressController.selectedDistrict = address;
                  addressController.update();
                  addressController.listOfSubdistrict(address.id);
                },
                onReset: () {
                  addressController.selectedDistrict = null;
                  addressController.selectedSubdistrict = null;
                  addressController.districtController.text = "";
                  addressController.subdistrictController.text = "";
                  addressController.update();
                  if (widget.onDistrictReset != null) {
                    widget.onDistrictReset!();
                  }

                  if (widget.onItemReset != null) {
                    widget.onItemReset!();
                  }
                },
              ),
            ),
          if (addressController.selectedDistrict != null)
            Container(
              margin: EdgeInsets.only(bottom: widget.marginBottom),
              child: AddressInputField(
                title: widget.subdistrictTitle,
                hint: widget.subdistrictHint ?? "Cari nama desa / kelurahan",
                isAddressSelected:
                    addressController.selectedSubdistrict != null,
                addressList: addressController.subdistrict,
                addressController: addressController.subdistrictController,
                selectedPrefixWidget: widget.selectedPrefixWidgetSubdistrict,
                prefixDropdownLabel:
                    widget.prefixDropdownLabelSubdistrict ?? "",
                prefixWidget: widget.inputPrefixWidget,
                boxDecoration: widget.boxDecoration,
                boxDecorationSelected: widget.selectedBoxDecoration,
                onSelected: (address) async {
                  addressController.selectedSubdistrict = address;
                  addressController.selectedPostalCode =
                      await addressController.getPostalCode() ?? "-";
                  addressController.update();
                  if (widget.onCompleted != null) {
                    AddressValue result = AddressValue(
                      addressController.selectedProvince!,
                      addressController.selectedCity!,
                      addressController.selectedDistrict!,
                      addressController.selectedSubdistrict!,
                      addressController.selectedPostalCode,
                    );
                    widget.onCompleted!(result);
                  }
                },
                onReset: () {
                  addressController.selectedSubdistrict = null;
                  addressController.subdistrictController.text = "";
                  addressController.update();
                  if (widget.onSubdistrictReset != null) {
                    widget.onSubdistrictReset!();
                  }

                  if (widget.onItemReset != null) {
                    widget.onItemReset!();
                  }
                },
              ),
            ),
        ],
      );
    });
  }
}
