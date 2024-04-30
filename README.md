# kodepos
Package to get postal code in indonesia (offline search)

## Pub.Dev
https://pub.dev/packages/kodepos

## Usage
To use this plugin, add ```kodepos``` as a [dependency in your pubspec.yaml](https://flutter.io/platform-plugins/).


### Demo 
###### KodeposDropdown Widget & KodeposMixin 
<p float="left">
<img src="https://private-user-images.githubusercontent.com/40958185/326697941-7d9a8a7a-8727-4999-b902-29b456da058c.gif?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTQ0NTk4MDYsIm5iZiI6MTcxNDQ1OTUwNiwicGF0aCI6Ii80MDk1ODE4NS8zMjY2OTc5NDEtN2Q5YThhN2EtODcyNy00OTk5LWI5MDItMjliNDU2ZGEwNThjLmdpZj9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA0MzAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNDMwVDA2NDUwNlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWQ4NWRiMDA0NjVmNDFiNWMyNmMwMjkwYzA4OGNlYzNlNzhhZTAwOWZiZjVmZmM5NGYyMWUyN2ZhNmM0ZThiOTgmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.BRsjAtDE-J5XESlZirgOAla0-zn-cbRFFqjtpfgiTPg" width=20% height=20% /> <img src="https://private-user-images.githubusercontent.com/40958185/326697894-3d71ebca-f163-400c-9d1e-f13195aaf517.gif?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTQ0NTk3NDIsIm5iZiI6MTcxNDQ1OTQ0MiwicGF0aCI6Ii80MDk1ODE4NS8zMjY2OTc4OTQtM2Q3MWViY2EtZjE2My00MDBjLTlkMWUtZjEzMTk1YWFmNTE3LmdpZj9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA0MzAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNDMwVDA2NDQwMlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTEyM2RiNTYwNjEyYTU5YzQzNWU2ZDFjZjA1NTJmNGU0NWEwNTJmNDZkNTY1N2Y5OGNiNGM1NjE1MzA3YmE1YmMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.wcgrYD65U-QCemaicda9g3FGlF_yUCo1QgMOycnnJ8w" width=20% height=20% />
</p>

### Example Of KodeposDropdown Widget
Use this if you want to select kodepos using widget
```dart
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

```
### Example of KodeposMixin
Use this if you only need the data 
```
import 'package:flutter/material.dart';
import 'package:kodepos/kodepos.dart';

class KodeposGetDataExample extends StatefulWidget {
  const KodeposGetDataExample({super.key});

  @override
  State<KodeposGetDataExample> createState() => _KodeposGetDataExampleState();
}

class _KodeposGetDataExampleState extends State<KodeposGetDataExample>
    with KodeposMixin {
  final TextEditingController provinceIdController = TextEditingController();
  final TextEditingController cityIdController = TextEditingController();
  final TextEditingController districtIdController = TextEditingController();
  final TextEditingController subdistrictIdController = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Kodepos Get Data Example"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                String result = "";
                List<ItemAddressValue>? provinces = await getListOfProvince();
                provinces?.forEach((element) {
                  result += "${element.id} - ${element.name}\n";
                });
                resultController.text = result;
              },
              child: const Text("Get List Province"),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: provinceIdController,
                      decoration: const InputDecoration(
                        hintText: "Province ID",
                        label: Text("Province ID"),
                      )),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String result = "";
                      List<ItemAddressValue>? cities = await getListOfCity(
                          provinceId: provinceIdController.text);
                      cities?.forEach((element) {
                        result += "${element.id} - ${element.name}\n";
                      });
                      resultController.text = result;
                    },
                    child: const Text("Get List Cities"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: cityIdController,
                      decoration: const InputDecoration(
                        hintText: "City ID",
                        label: Text("City ID"),
                      )),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String result = "";
                      List<ItemAddressValue>? districts =
                          await getListOfDistrict(
                              cityId: cityIdController.text);
                      districts?.forEach((element) {
                        result += "${element.id} - ${element.name}\n";
                      });
                      resultController.text = result;
                    },
                    child: const Text("Get List District"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: districtIdController,
                      decoration: const InputDecoration(
                        hintText: "District ID",
                        label: Text("District ID"),
                      )),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String result = "";
                      List<ItemAddressValue>? subdistricts =
                          await getListOfSubDistrict(
                              districtId: districtIdController.text);
                      subdistricts?.forEach((element) {
                        result += "${element.id} - ${element.name}\n";
                      });
                      resultController.text = result;
                    },
                    child: const Text("Get List SubDistrict"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: subdistrictIdController,
                      decoration: const InputDecoration(
                        hintText: "SubDistrict ID",
                        label: Text("SubDistrict ID"),
                      )),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String? postalCode = await getPostalCode(
                          cityId: cityIdController.text,
                          districtId: districtIdController.text,
                          subdistrictId: subdistrictIdController.text);
                      debugPrint("Postal Code: $postalCode");
                      if (context.mounted) {
                        var snackBar = SnackBar(
                          content: Text(postalCode ?? "Postal Code not found"),
                          dismissDirection: DismissDirection.up,
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text("Get Postalcode"),
                  ),
                ),
              ],
            ),
            TextField(
              minLines: 10,
              maxLines: 10,
              controller: resultController,
              decoration: const InputDecoration(
                hintText: "Result",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```