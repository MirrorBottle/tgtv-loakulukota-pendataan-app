import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/villager_data.dart';
import 'package:loakulukota_app/services/item_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
import 'package:flutter_svg/flutter_svg.dart';

class VillagerListTile extends StatelessWidget {
  final VillagerListModel item;
  const VillagerListTile({required Key key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          onTap: () => Navigator.pushNamed(
            context,
            'item-detail',
            arguments: {"id": item.id},
          ),
          minLeadingWidth: 20,
          title: Text(item.name,
              style: const TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(item.idNumber)
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.arrow_forward_ios,
                size: 16.0,
              )
            ],
          ),
        )
      ],
    );
  }
}

class VillagerListScreen extends StatefulWidget {
  const VillagerListScreen({Key? key}) : super(key: key);

  @override
  _VillagerListScreenState createState() => _VillagerListScreenState();
}

class _VillagerListScreenState extends State<VillagerListScreen> {
  final ItemService _itemService = ItemService();
  final List<VillagerListModel> _items = [
    VillagerListModel(id: 1, idNumber: "6311081712780001", name: "Murhani")
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    // EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    // List<VillagerListModel> _itemsData = await _itemService.list();
    // setState(() {
    //   _items = _itemsData;
    // });
    // EasyLoading.dismiss();
  }

  Future<void> _refresh() async {
    // EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    // List<VillagerListModel> _itemsData = await _itemService.list();
    // setState(() {
    //   _items = _itemsData;
    // });
    // EasyLoading.dismiss();
  }

  void _handleSearch(String keyword) async {
    // EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    // List<VillagerListModel> _itemsData = await _itemService.list(keyword: keyword);
    // setState(() {
    //   _items = _itemsData;
    // });
    // EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: constPrimaryColor,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: constPrimaryColor,
            elevation: 0.0,
            titleSpacing: 0.0,
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 40.0, bottom: 25),
              child: Text(
                'Penduduk',
                style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  constraints: BoxConstraints(minHeight: context.height() - 80),
                  width: context.width(),
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) => _handleSearch(value),
                        decoration: const InputDecoration(
                          hintText: "Cari dengan NIK atau nama...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ..._items
                          .map<Widget>((item) => VillagerListTile(
                              key: ObjectKey(item),
                              item: item))
                          .toList()
                    ],
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
