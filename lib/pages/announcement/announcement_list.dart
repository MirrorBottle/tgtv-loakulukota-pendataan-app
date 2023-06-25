import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loakulukota_app/services/announcement_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/constant.dart';

import 'package:loakulukota_app/models/announcement_data.dart';

class AnnouncementListTile extends StatelessWidget {
  final AnnouncementModel item;
  const AnnouncementListTile({required Key key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          onTap: () {},
          minLeadingWidth: 20,
          title: Text(item.title, style: const TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const SizedBox(height: 5), Text(item.content)],
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

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementListScreenState createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final _requestLimit = 5;
  final PagingController<int, AnnouncementModel> _pagingController =
      PagingController(firstPageKey: 1);

  final AnnouncementService _announcementService = AnnouncementService();

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

  Future<void> _fetch(int pageKey, {String keyword=''}) async {
    try {
      List<AnnouncementModel> _announcementsData =
          await _announcementService.list(keyword: keyword, page: pageKey, limit: _requestLimit);
      if(keyword != '') {
        _pagingController.itemList = _announcementsData;
      } else {

        if(pageKey == 1) {
          _pagingController.itemList = [];
        }

        final isLastPage = _announcementsData.length < _requestLimit;
        if (isLastPage) {
          _pagingController.appendLastPage(_announcementsData);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(_announcementsData, nextPageKey);
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
              padding: const EdgeInsets.only(left: 20.0, top: 50.0, bottom: 25),
              child: Text(
                'Daftar Pengumuman',
                style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: BackButton(),
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
                  TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) => _handleSearch(value),
                    decoration: const InputDecoration(
                      hintText: "Cari judul pengumuman...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: PagedListView<int, AnnouncementModel>(
                        pagingController: _pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<AnnouncementModel>(
                          itemBuilder: (context, item, index) =>
                              AnnouncementListTile(
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
