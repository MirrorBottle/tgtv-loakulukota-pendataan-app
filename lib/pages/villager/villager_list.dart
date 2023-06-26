import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loakulukota_app/services/villager_service.dart';
import 'package:loakulukota_app/models/villager_data.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/constant.dart';


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
            'villager-detail',
            arguments: {"id": item.id},
          ),
          minLeadingWidth: 20,
          title: Text(item.name, style: const TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const SizedBox(height: 5), Text(item.idNumber)],
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
  Map<String, dynamic> _auth = {};
  final _requestLimit = 5;
  final PagingController<int, VillagerListModel> _pagingController =
      PagingController(firstPageKey: 1);

  final VillagerService _villagerService = VillagerService();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetch(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
  Future<void> _fetch(int pageKey, {String keyword = ''}) async {
    try {
      List<VillagerListModel> _villagersData = await _villagerService
          .list(keyword: keyword, page: pageKey, limit: _requestLimit);
      if (keyword != '') {
        _pagingController.itemList = _villagersData;
      } else {
        if (pageKey == 1) {
          _pagingController.itemList = [];
        }

        final isLastPage = _villagersData.length < _requestLimit;
        if (isLastPage) {
          _pagingController.appendLastPage(_villagersData);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(_villagersData, nextPageKey);
        }
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  void _handleSearch(String keyword) async {
    _fetch(1, keyword: keyword);
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
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: Container(
              height: context.height() - 80,
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: TextField(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(top: 16, bottom: 16)),
                              backgroundColor:
                                  MaterialStateProperty.all(constPrimaryColor)),
                          child: const Icon(Icons.filter_alt_outlined,
                              color: Colors.white, size: 25)),
                    )
                  ]),
                  const SizedBox(height: 20),
                  Expanded(
                    child: PagedListView<int, VillagerListModel>(
                        pagingController: _pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<VillagerListModel>(
                          itemBuilder: (context, item, index) =>
                              VillagerListTile(
                                  key: ObjectKey(item), item: item),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
