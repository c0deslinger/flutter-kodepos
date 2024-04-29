import 'package:kodepos/src/model/item_address_value.dart';

class AddressValue {
  final ItemAddressValue province;
  final ItemAddressValue city;
  final ItemAddressValue district;
  final ItemAddressValue subdistrict;
  final String postalCode;

  AddressValue(this.province, this.city, this.district, this.subdistrict,
      this.postalCode);
}
