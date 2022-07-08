import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'v2_component.dart';
import 'v2_val.dart';

class V2FilterDashboardButton extends StatelessWidget {
  V2FilterDashboardButton({Key? key}) : super(key: key);

  final _fileterType = {};
  // final _filterStatus = {}.val("filter_status").obs;
  final _filterModule = {};
  final _filterProduct = {};
  final _filterClient = {};
  // final _filterUser = {}.val("filter_user").obs;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade200,
      child: Center(
        child: IconButton(
          onPressed: () => _popUpDialogFilter(context),
          icon: Icon(
            Icons.filter_alt,
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }

  _popUpDialogFilter(BuildContext context) => showBottomSheet(
        context: context,
        builder: (context) => V2Component.drawerFilter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _dropdownSearch(items: V2Val.listType.value.val, title: "Type", values: _fileterType),
                // _dropdownSearch(items: V2Val.listStatus.value.val, title: "Status", values: _filterStatus),
                _dropdownSearch(items: V2Val.listModule.value.val, title: "Module", values: _filterModule),
                _dropdownSearch(items: V2Val.listProduct.value.val, title: "Product", values: _filterProduct),
                _dropdownSearch(items: V2Val.listClient.value.val, title: "Client", values: _filterClient),
                // _dropdownSearch(items: V2Val.listUser.value.val, title: "User", values: _filterUser),
                SizedBox(
                  height: 70,
                ),
                MaterialButton(
                  color: Colors.cyan,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text("Filter",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  onPressed: () {
                    List bk = V2Val.backupListIssueDashboard.value.val;
                    List ls = [...bk];

                    if (_fileterType.isNotEmpty) {
                      ls = ls.where((element) => element['IssueType']['name'] == _fileterType['name']).toList();
                    }

                    if (_filterModule.isNotEmpty) {
                      ls = ls.where((element) => element['Departement']['name'] == _filterModule['name']).toList();
                    }

                    if (_filterProduct.isNotEmpty) {
                      ls = ls.where((element) => element['Product']['name'] == _filterProduct['name']).toList();
                    }

                    if (_filterClient.isNotEmpty) {
                      ls = ls.where((element) => element['Client']['name'] == _filterClient['name']).toList();
                    }

                    V2Val.listIssueDashboard.value.val = ls;
                    V2Val.listIssueDashboard.refresh();
                    // debugPrint(ls.toString());
                  },
                )
              ],
            ),
          ),
        ),
      );

  _dropdownSearch({String? title, Map? values, required List items}) {
    final selected = values!.isEmpty ? {"name": "all", "id": "all"} : values;
    // if (!items.map((e) => e['name']).toList().contains("all")) {
    //   items.insert(0, {"name": "all", "id": "all"});
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Filter By $title"),
        DropdownSearch(
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none, hintText: "Filter By $title", label: Text("Filter By $title")),
          ),
          itemAsString: (Map item) => item['name'].toString(),
          items: List<Map>.from(items),
          selectedItem: selected,
          onChanged: (item) {
            Map val = item as Map;
            if (val['name'] == "all") {
              val = {};
            } else {
              val = val;
            }

            values.assignAll(val);
            // debugPrint(item.toString());
          },
        ),
        // Divider()
      ],
    );
  }
}
