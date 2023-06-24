import 'package:loakulukota_app/pages/home/home_screen.dart';
import 'package:loakulukota_app/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/item_data.dart';
import 'package:loakulukota_app/services/item_service.dart';
import 'package:loakulukota_app/services/inventory_log_service.dart';
import 'package:loakulukota_app/models/inventory_log_data.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:math';

Random random = Random();

typedef OnDelete();

class InventoryCreateStockForm extends StatefulWidget {
  InventoryCreateStockModel? stock;
  final OnDelete onDelete;
  final List<ItemListModel> items;
  final state = _InventoryCreateStockFormState;

  InventoryCreateStockForm(
      {Key? key, this.stock, required this.onDelete, required this.items})
      : super(key: key);
  @override
  State<InventoryCreateStockForm> createState() =>
      _InventoryCreateStockFormState();
}

class _InventoryCreateStockFormState extends State<InventoryCreateStockForm> {
  final form = GlobalKey<FormState>();
  final _quantity = TextEditingController();
  ItemListModel? _item;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Form(
            key: form,
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: constPrimaryColor,
                  title: Text(
                    'Data Barang',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: 16.0),
                  ),
                  actions: [
                    IconButton(
                      onPressed: widget.onDelete,
                      icon: const Icon(Icons.delete),
                      padding: const EdgeInsets.only(right: 10),
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        DropdownSearch<ItemListModel>(
                          mode: Mode.MENU,
                          //country data as item
                          items: widget.items,
                          showSearchBox: true,
                          itemAsString: (item) =>
                              "${item!.name} (Stok: ${item.stock})",
                          dropdownSearchDecoration: InputDecoration(
                            floatingLabelStyle: const TextStyle(
                              fontSize: 20,
                            ),
                            labelStyle: kTextStyle,
                            hintText: "Pilih Barang",
                            suffixIcon: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text('Box')),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBorderColorTextField),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          selectedItem: widget.stock!.item,
                          onChanged: (value) {
                            widget.stock!.item = value;
                            setState(() {
                              _item = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppTextField(
                          initialValue: widget.stock!.quantity != 0
                              ? widget.stock!.quantity.toString()
                              : '',
                          textFieldType: TextFieldType.OTHER,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            widget.stock!.quantity = value.toInt();
                          },
                          decoration: InputDecoration(
                            hintText: "Total Barang Keluar",
                            floatingLabelStyle: const TextStyle(
                              fontSize: 20,
                            ),
                            labelStyle: kTextStyle,
                            suffixIcon: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(widget.stock!.item != null
                                    ? widget.stock!.item!.unit
                                    : '-')),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBorderColorTextField),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}

class InventoryCreateOutScreen extends StatefulWidget {
  const InventoryCreateOutScreen({Key? key}) : super(key: key);

  @override
  _InventoryCreateOutScreenState createState() =>
      _InventoryCreateOutScreenState();
}

class _InventoryCreateOutScreenState extends State<InventoryCreateOutScreen> {
  final ItemService _itemService = ItemService();
  final InventoryLogService _inventoryLogService = InventoryLogService();
  bool _isForm = true;
  List<ItemListModel> _items = [];
  List<InventoryCreateStockModel> _stocks = [];

  final _note = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    List<ItemListModel> _itemsData = await _itemService.list();
    setState(() {
      _items = _itemsData;
      _stocks.add(InventoryCreateStockModel(id: random.nextInt(1000000)));
    });
    EasyLoading.dismiss();
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Apa anda yakin?'),
            content: const Text('Data belum tersimpan.'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: const Padding(
                    padding: EdgeInsets.all(10), child: Text("Tidak")),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Ya",
                      style: TextStyle(color: constPrimaryColor),
                    )),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _onSaveSubmit() async {
    awesome_dialog.AwesomeDialog(
            context: context,
            dialogType: awesome_dialog.DialogType.WARNING,
            animType: awesome_dialog.AnimType.BOTTOMSLIDE,
            title: 'Apakah anda yakin?',
            desc: 'Pastikan daftar barang keluar sudah benar!',
            btnOkText: "Ya",
            btnOkOnPress: () async {
              EasyLoading.show(
                  status: 'Mohon Ditunggu',
                  maskType: EasyLoadingMaskType.black);
              await _inventoryLogService.create(type: 1, stocks: _stocks, note: _note.text);
              EasyLoading.dismiss();
              awesome_dialog.AwesomeDialog(
                      context: context,
                      animType: awesome_dialog.AnimType.BOTTOMSLIDE,
                      headerAnimationLoop: false,
                      dialogType: awesome_dialog.DialogType.SUCCES,
                      showCloseIcon: true,
                      title: 'Berhasil',
                      desc: 'Berhasil Verifikasi Barang Keluar!',
                      btnOkOnPress: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                            (Route route) => false);
                      },
                      onDissmissCallback: (type) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                            (Route route) => false);
                      },
                      btnOkIcon: Icons.check_circle)
                  .show();
            },
            btnCancelText: "Tidak",
            btnCancelOnPress: () {})
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
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
              padding: const EdgeInsets.only(left: 5, top: 50.0, bottom: 25),
              child: Text(
                'Tambah Barang Keluar',
                style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: BackButton(),
            ),
          ),
          floatingActionButton: _isForm
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 100.0, right: 12),
                  child: FloatingActionButton(
                    child: const Icon(Icons.add),
                    backgroundColor: constPrimaryColor,
                    onPressed: () {
                      setState(() {
                        _stocks.add(InventoryCreateStockModel(
                            id: random.nextInt(1000000)));
                      });
                    },
                  ))
              : null,
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
                  children: _isForm
                      ? [
                          Column(children: [
                            const SizedBox(height: 10),
                            ..._stocks
                                .map((_stock) => InventoryCreateStockForm(
                                    items: _items,
                                    stock: _stock,
                                    onDelete: () {
                                      if (_stocks.length > 1) {
                                        setState(() {
                                          _stocks = _stocks
                                              .where((stock) =>
                                                  stock.id != _stock.id)
                                              .toList();
                                        });
                                      }
                                    }))
                                .toList()
                          ]),
                          const SizedBox(
                            height: 100,
                          ),
                          ButtonGlobal(
                            buttontext: 'Lanjut',
                            buttonDecoration: constButtonDecoration.copyWith(
                                color: constPrimaryColor),
                            onPressed: () => setState(() {
                              _isForm = false;
                            }),
                          ),
                        ]
                      : [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                Text(
                                  "Daftar Barang",
                                  textAlign: TextAlign.left,
                                  style: constListTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                ..._stocks
                                    .where((_stock) =>
                                        _stock.item != null &&
                                        _stock.quantity != 0)
                                    .map<Widget>((_stock) => ListTile(
                                          leading: Text(
                                              "(${_stock.item!.code}) ${_stock.item!.name}"),
                                          trailing: Text(
                                            "-${_stock.quantity} ${_stock.item!.unit}",
                                            style: const TextStyle(
                                                color: constPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                        ))
                                    .toList(),
                                const SizedBox(height: 30),
                                Text(
                                  "Catatan",
                                  textAlign: TextAlign.left,
                                  style: constListTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                AppTextField(
                                  controller: _note,
                                  textFieldType: TextFieldType.MULTILINE,
                                  minLines: 4,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(
                                      fontSize: 20,
                                    ),
                                    labelStyle: kTextStyle,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: kBorderColorTextField),
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ]),
                          Column(children: [
                            ButtonGlobal(
                              buttontext: 'Kembali',
                              buttonDecoration: constButtonDecoration.copyWith(
                                  color: constPrimaryColor),
                              onPressed: () => setState(() {
                                _isForm = true;
                              }),
                            ),
                            const SizedBox(height: 10),
                            ButtonGlobal(
                              buttontext: 'Simpan',
                              buttonDecoration: constButtonDecoration.copyWith(
                                  color: constSuccessColor),
                              onPressed: _onSaveSubmit,
                            ),
                          ]),
                        ],
                ),
              ),
            ],
          )),
        ));
  }
}
