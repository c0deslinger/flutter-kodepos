import 'package:flutter/material.dart';
import 'package:kodepos/kodepos.dart';

class KodeposDropdownExample extends StatefulWidget {
  const KodeposDropdownExample({super.key});

  @override
  State<KodeposDropdownExample> createState() => _KodeposDropdownExampleState();
}

class _KodeposDropdownExampleState extends State<KodeposDropdownExample> {
  TextEditingController resultController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Kodepos Dropdown Example'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              KodeposDropdown(
                prefixDropdownLabelProvince: "Provinsi ",
                prefixDropdownLabelCity: "Kota ",
                marginBottom: 0,
                selectedBoxDecoration: const BoxDecoration(),
                selectedPrefixWidgetProvince:
                    createPrefixWidget(isFirstItem: true),
                selectedPrefixWidgetCity: createPrefixWidget(),
                selectedPrefixWidgetDistrict: createPrefixWidget(),
                selectedPrefixWidgetSubdistrict:
                    createPrefixWidget(isLastItem: true),
                onCompleted: (result) {
                  setState(() {
                    resultController.text =
                        "Desa ${result.subdistrict.name}, Kec. ${result.district.name}\n${result.city.name}, ${result.province.name}\n${result.postalCode}";
                  });
                },
                onItemReset: () {
                  setState(() {
                    resultController.text = "";
                  });
                },
              ),
              if (resultController.text.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: TextField(
                      controller: resultController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          labelText: 'Result',
                          hintText: 'Result',
                          border: OutlineInputBorder())),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createCirclePrefix({double size = 20}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.withOpacity(.2),
      ),
      width: size,
      height: size,
      child: Center(
        child: Container(
          width: size - 8,
          height: size - 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(.5),
          ),
        ),
      ),
    );
  }

  Widget createPrefixWidget(
      {bool isFirstItem = false, bool isLastItem = false, double size = 20}) {
    return Container(
      width: size,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              width: 1,
              color: isFirstItem
                  ? Colors.transparent
                  : Colors.grey.withOpacity(.2),
            ),
          ),
          Flexible(child: _createCirclePrefix(size: size)),
          Flexible(
            child: Container(
              width: 1,
              color:
                  isLastItem ? Colors.transparent : Colors.grey.withOpacity(.2),
            ),
          ),
        ],
      ),
    );
  }
}
