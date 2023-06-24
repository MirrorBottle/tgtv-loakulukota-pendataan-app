import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/verification_data.dart';
import 'package:loakulukota_app/services/verification_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
import 'package:flutter_svg/flutter_svg.dart';

class VerificationListTile extends StatelessWidget {
  final VerificationListModel verification;
  const VerificationListTile({required Key key, required this.verification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          onTap: () => Navigator.pushNamed(
            context,
            'verification-detail',
            arguments: {"id": verification.id},
          ),
          minLeadingWidth: 20,
          title: Text(verification.userName,
              style: const TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(verification.date),
              const SizedBox(height: 5),
              Text("${verification.itemsCount} Item")
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

class VerificationListScreen extends StatefulWidget {
  const VerificationListScreen({Key? key}) : super(key: key);

  @override
  _VerificationListScreenState createState() => _VerificationListScreenState();
}

class _VerificationListScreenState extends State<VerificationListScreen> {
  final VerificationService _verificationService = VerificationService();
  List<VerificationListModel> _verifications = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    List<VerificationListModel> _verificationsData =
        await _verificationService.list();
    setState(() {
      _verifications = _verificationsData;
    });
    EasyLoading.dismiss();
  }

  Future<void> _refresh() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    List<VerificationListModel> _verificationsData =
        await _verificationService.list();
    setState(() {
      _verifications = _verificationsData;
    });
    EasyLoading.dismiss();
  }

  Future<void> _onVerifiedAllPressed() async {
    awesome_dialog.AwesomeDialog(
            context: context,
            dialogType: awesome_dialog.DialogType.WARNING,
            animType: awesome_dialog.AnimType.BOTTOMSLIDE,
            title: 'Apakah anda yakin?',
            desc: 'Semua barang keluar akan tervalidasi benar!',
            btnOkText: "Ya",
            btnOkOnPress: () async {
              EasyLoading.show(
                  status: 'Mohon Ditunggu',
                  maskType: EasyLoadingMaskType.black);
              await _verificationService.verifiedAll();
              List<VerificationListModel> _verificationsData =
                  await _verificationService.list();
              setState(() {
                _verifications = _verificationsData;
              });
              EasyLoading.dismiss();
            },
            btnCancelText: "Tidak",
            btnCancelOnPress: () {})
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
                'Validasi',
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
                    crossAxisAlignment: _verifications.isNotEmpty
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.center,
                    children: [
                      if (_verifications.isNotEmpty) ...[
                        TextButton.icon(
                            onPressed: _verifications.isEmpty
                                ? null
                                : _onVerifiedAllPressed,
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Validasi Semua",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: constSuccessButtonStyle)
                      ],
                      const SizedBox(height: 40),
                      if (_verifications.isNotEmpty)
                        ..._verifications
                            .map<Widget>((verification) => VerificationListTile(
                                key: ObjectKey(verification),
                                verification: verification))
                            .toList()
                      else ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/done.svg',
                              width: 300,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Belum ada barang keluar, nih...",
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
