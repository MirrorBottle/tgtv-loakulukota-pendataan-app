import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/item_data.dart';
import 'package:loakulukota_app/services/item_service.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ItemDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const ItemDetailScreen({this.args, Key? key}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  final ItemService _itemService = ItemService();
  ItemDetailModel? _item;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    ItemDetailModel _itemData =
        await _itemService.detail(id: widget.args!['id']);
    setState(() {
      _item = _itemData;
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
              padding: const EdgeInsets.only(left: 20.0, top: 50.0, bottom: 25),
              child: Text(
                'Detail Histori',
                style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: BackButton(),
            ),
          ),
          body: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_item != null) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            _item!.name,
                            style: constHeadingStyle.copyWith(fontSize: 19),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: context.width(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Detail Data",
                                  textAlign: TextAlign.left,
                                  style: constListTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  leading: const Text("Kode"),
                                  trailing: Text(_item!.code),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: const Text("Kategori"),
                                  trailing: Text(_item!.inventoryCategoryName),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: const Text("Satuan"),
                                  trailing: Text(_item!.unit),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: const Text("Stok Rendah"),
                                  trailing: Text("${_item!.lowQuantity.toString()} ${_item!.unit}"),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: const Text("Stok Tersisa"),
                                  trailing: Text("${_item!.stock.toString()} ${_item!.unit}"),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                    ButtonGlobal(
                      buttontext: 'Kembali',
                      buttonDecoration: constButtonDecoration.copyWith(
                          color: constPrimaryColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}
