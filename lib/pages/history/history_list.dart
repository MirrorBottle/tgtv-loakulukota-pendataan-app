import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/inventory_log_data.dart';
import 'package:loakulukota_app/services/inventory_log_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';


class InventoryLogHistoryTile extends StatelessWidget {
  final InventoryLogHistoryModel inventory;
  const InventoryLogHistoryTile({required Key key, required this.inventory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          onTap: () => Navigator.pushNamed(
            context,
            'history-detail',
            arguments: {"id": inventory.id},
          ),
          minLeadingWidth: 35,
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                inventory.type == "1" ? Icons.outbox : Icons.move_to_inbox,
                size: 30,
                color: inventory.type == "1" ? constPrimaryColor : constSuccessColor,
              )
            ],
          ),
          title: Text("${inventory.code} - ${inventory.userName}",
              style: const TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(inventory.date),
              const SizedBox(height: 5),
              Text("${inventory.itemsCount} Item")
            ],
          ),
          isThreeLine: true,
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

class HistoryListScreen extends StatefulWidget {
  const HistoryListScreen({Key? key}) : super(key: key);

  @override
  _HistoryListScreenState createState() => _HistoryListScreenState();
}

class _HistoryListScreenState extends State<HistoryListScreen> {
  final InventoryLogService _inventoryLogService = InventoryLogService();
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime.utc(
        DateTime.now().year,
        DateTime.now().month + 1,
      ).subtract(const Duration(days: 1)));
  List<InventoryLogHistoryModel> _logs = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    List<InventoryLogHistoryModel> _logsData = await _inventoryLogService.history(startDate: DateFormat("y-MM-dd").format(dateRange.start), endDate: DateFormat("y-MM-dd").format(dateRange.end));
    setState(() {
      _logs = _logsData;
    });
    EasyLoading.dismiss();
  }

  Future<void> _refresh() async {
    EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    List<InventoryLogHistoryModel> _logsData = await _inventoryLogService.history(startDate: DateFormat("y-MM-dd").format(dateRange.start), endDate: DateFormat("y-MM-dd").format(dateRange.end));
    setState(() {
      _logs = _logsData;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    Future _pickDateRange() async {
      DateTimeRange? newDateRange = await showDateRangePicker(
          context: context,
          initialDateRange: dateRange,
          firstDate: DateTime(2021),
          lastDate: DateTime(2100));
      if (newDateRange == null) return;
      setState(() => dateRange = newDateRange);
      _refresh();
    }

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
                'Histori',
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
                    crossAxisAlignment: _logs.isNotEmpty
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Tanggal Awal"),
                                const SizedBox(height: 10),
                                TextButton.icon(
                                  icon: const Icon(Icons.calendar_today,
                                      color: Colors.white),
                                  label: Text(
                                      '${start.day}/${start.month}/${start.year}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  onPressed: _pickDateRange,
                                  style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(55))),
                                      backgroundColor: constPrimaryColor,
                                      padding: const EdgeInsets.only(
                                          bottom: 20,
                                          left: 20,
                                          right: 20,
                                          top: 20)),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Tanggal Akhir"),
                                const SizedBox(height: 10),
                                TextButton.icon(
                                  icon: const Icon(Icons.calendar_today,
                                      color: Colors.white),
                                  label: Text(
                                      '${end.day}/${end.month}/${end.year}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  onPressed: _pickDateRange,
                                  style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(55))),
                                      backgroundColor: constPrimaryColor,
                                      padding: const EdgeInsets.only(
                                          bottom: 20,
                                          left: 20,
                                          right: 20,
                                          top: 20)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      if (_logs.isNotEmpty)
                        ..._logs
                            .map<Widget>((inventory) => InventoryLogHistoryTile(
                                key: ObjectKey(inventory),
                                inventory: inventory))
                            .toList()
                      else ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/empty.svg',
                              width: 300,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Histori kosong!",
                              style: constHeadingStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
