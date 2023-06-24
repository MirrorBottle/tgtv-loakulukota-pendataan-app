import 'package:flutter/material.dart';
import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/pages/home/main_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/services/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loakulukota_app/models/auth.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final AuthService _authService = AuthService();
  Map<dynamic, dynamic> _maintenance = {'message': ''};
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    Map<dynamic, dynamic> _maintenanceData = await _authService.maintenance();
    setState(() {
      _maintenance = _maintenanceData;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: constPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: constPrimaryColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height * .1,
        maxHeight: MediaQuery.of(context).size.height * 1,
        panelBuilder: (sc) => MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            controller: sc,
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text("Tentang Aplikasi", style: constHeadingStyle, textAlign: TextAlign.center,),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14.0),
            topRight: Radius.circular(14.0)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/placeholder.svg',
                      width: 400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Aplikasi Dalam Perawatan!",
                      style: constHeadingStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _maintenance['message'],
                      style: constSubStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}