import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/item_data.dart';
import 'package:loakulukota_app/services/item_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
import 'package:flutter_svg/flutter_svg.dart';

class ItemListTile extends StatelessWidget {
  final ItemListModel item;
  const ItemListTile({required Key key, required this.item})
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
          title: Text("(${item.code}) ${item.name}",
              style: const TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text("Tersisa: ${item.stock} ${item.unit}")
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

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final ItemService _itemService = ItemService();
  List<ItemListModel> _items = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    List<ItemListModel> _itemsData = await _itemService.list();
    setState(() {
      _items = _itemsData;
    });
    EasyLoading.dismiss();
  }

  Future<void> _refresh() async {
    EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    List<ItemListModel> _itemsData = await _itemService.list();
    setState(() {
      _items = _itemsData;
    });
    EasyLoading.dismiss();
  }

  void _handleSearch(String keyword) async {
    EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    List<ItemListModel> _itemsData = await _itemService.list(keyword: keyword);
    setState(() {
      _items = _itemsData;
    });
    EasyLoading.dismiss();
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
                'Gudang',
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
                          hintText: "Cari barang...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ..._items
                          .map<Widget>((item) => ItemListTile(
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
