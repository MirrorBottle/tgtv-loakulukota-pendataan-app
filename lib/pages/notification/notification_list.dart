import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/notification_data.dart';
import 'package:loakulukota_app/services/notification_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
import 'package:flutter_svg/flutter_svg.dart';

class NotificationListTile extends StatelessWidget {
  final NotificationListModel notification;
  const NotificationListTile({ required Key key, required this.notification }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile( 
          onTap: () => Navigator.pushNamed(
            context,
            'notification-detail',
            arguments: {"id": notification.id},
          ),
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 16.0,
                color: notification.isRead ? Colors.grey : Colors.green,
              )
            ],
          ),
          minLeadingWidth : 20,
          title: Text(notification.title, style: TextStyle(color: notification.isRead ? const Color.fromARGB(255, 90, 90, 90) : Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification.datetime),
              const SizedBox(height: 5),
              Text(notification.message)
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

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  final NotificationService _notificationService = NotificationService();
  List<NotificationListModel> _notifications = [];
  
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    // EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    // List<NotificationListModel> _notificationsData = await _notificationService.list();
    // setState(() {
    //   _notifications = _notificationsData;
    // });
    // EasyLoading.dismiss();
  }

  Future<void> _refresh() async {
    // EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    // List<NotificationListModel> _notificationsData = await _notificationService.list();
    // setState(() {
    //   _notifications = _notificationsData;
    // });
    // EasyLoading.dismiss();
  }

  Future<void> _onDeleteAllPressed() async {
    awesome_dialog
      .AwesomeDialog(
        context: context,
        dialogType: awesome_dialog.DialogType.WARNING,
        animType: awesome_dialog.AnimType.BOTTOMSLIDE,
        title: 'Apakah anda yakin?',
        desc: 'Semua pesan akan dihapus dan tidak bisa dikembalikan',
        btnOkText: "Ya",
        btnOkOnPress: () async {
          EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
          await _notificationService.deleteAll();
          List<NotificationListModel> _notificationsData = await _notificationService.list();
          setState(() {
            _notifications = _notificationsData;
          });
          EasyLoading.dismiss();
        },
        btnCancelText: "Tidak",
        btnCancelOnPress: () {}
      )
      .show();
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
              'Pesan',
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
                  constraints: BoxConstraints(
                    minHeight: context.height() - 80
                  ),
                  width: context.width(),
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: _notifications.isNotEmpty ? CrossAxisAlignment.end : CrossAxisAlignment.center,
                    children: [
                      if(_notifications.isNotEmpty)...[
                        TextButton.icon(
                          onPressed: _notifications.isEmpty ? null : _onDeleteAllPressed,
                          icon: const Icon(Icons.delete_forever, color: Colors.white,),
                          label: const Text(
                            "Hapus Pesan",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: constDangerButtonStyle
                        )
                      ],
                      const SizedBox(height: 40),
                      if (_notifications.isNotEmpty) ..._notifications.map<Widget>((notification) => NotificationListTile(key: ObjectKey(notification), notification: notification)).toList()
                      else ... [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/empty.svg',
                              width: 300,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Pesanmu kosong!",
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
            )
          ),
        ),
      )
    );
  }
}
