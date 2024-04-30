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
